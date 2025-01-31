from airflow.decorators import dag, task
from datetime import datetime
import requests

from airflow.sensors.base import PokeReturnValue


@dag(start_date=datetime(2022, 12, 1), schedule="@daily", catchup=False)
def sensor_decorator():

    #poke_interval: frequency in which we want to check if a condition is true or not (every 30 seconds)
    #timeout: This is the maximum amount of time (in seconds) the sensor should keep checking for the condition to be met
    #         If the condition is not met within this time frame, the task will fail. In this case, the sensor will time out after 1 hour (3600 seconds).		
    #mode:This defines the mode in which the sensor will operate. With "poke" mode, the sensor keeps checking the condition at regular intervals until the condition is met or the timeout is reached. 
    #     There’s also an "reschedule" mode, where the task gets paused and only resumes at the next poke interval, which is more efficient in certain situations.	

    @task.sensor(poke_interval=30, timeout=3600, mode="poke")
    def check_shibe_availability() -> PokeReturnValue:
        r = requests.get("http://shibe.online/api/shibes?count=1&urls=true")
        print(r.status_code)

        if r.status_code == 200:
            condition_met = True
            operator_return_value = r.json()
        else:
            condition_met = False
            operator_return_value = None
            print(f"Shibe URL returned the status code {r.status_code}")

        return PokeReturnValue(is_done=condition_met, xcom_value=operator_return_value)

    # print the URL to the picture
    @task
    def print_shibe_picture_url(url):
        print(url)

    print_shibe_picture_url(check_shibe_availability())


sensor_decorator()