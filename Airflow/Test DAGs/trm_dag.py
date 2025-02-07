from airflow.operators.dummy import DummyOperator
from airflow import DAG  ## Import DAG to define Dag
from datetime import datetime ## Import datetime
from airflow.operators.python import PythonOperator ## Import PythonOperator
import pytz
import requests
from airflow.models import Variable
import json

default_args = {
    'retries': 3,
}

# Set the timezone for Bogotá (Colombia)
def get_time(ti):
    bogota_tz = pytz.timezone('America/Montevideo')
    bogota_time = datetime.now(bogota_tz)
    bogota_time = bogota_time.strftime("%m/%d/%Y, %H:%M:%S")
    print(type(bogota_time))
    print(bogota_time)
    ti.xcom_push("bogota_time", bogota_time)

def get_trm(ti):
    url = 'https://dolarapi.com/v1/cotizaciones/uyu'
    response = requests.get(url)
    response_json = response.json()
    trm = response_json['compra']
    print(response_json)
    print(trm)
    print(type(trm))
    ti.xcom_push("trm", trm)

def get_name(ti):
    name = Variable.get("person_name", default_var=None)
    print(name)
    print(type(name))
    ti.xcom_push("person_name", name)

def get_job(ti):
    job = Variable.get("job_summary", deserialize_json=True, default_var=None)["job_name"]
    print(job)
    print(type(job))
    ti.xcom_push("job_name", job)

def get_personal_info(ti):
    description = Variable.get("person_description", default_var=None)
    print(description)
    print(type(description))
    ti.xcom_push("person_description", description)

def get_print(**kwargs):
    ti = kwargs['ti']
    trm = ti.xcom_pull(key = 'trm',task_ids = 'GetCurrentTRM')
    time = ti.xcom_pull(key = 'bogota_time',task_ids = 'GetCurrentTime')
    job_name = ti.xcom_pull(key = 'job_name',task_ids = 'GetJob')
    person_name = ti.xcom_pull(key = 'person_name',task_ids = 'GetPersonName')
    wage = ti.xcom_pull(key = 'person_description',task_ids = 'GetPersonDescription')
    wage = json.loads(wage)
    wage = wage["Wage"]
    print(trm)
    print(type(trm))
    print(time)
    print(type(time))
    print(job_name)
    print(type(job_name))
    print(person_name)
    print(type(person_name))
    print(wage)
    print(type(wage))

with DAG(dag_id='job_person_message', start_date=datetime(2023, 1, 1), default_args=default_args,
         description='A sample tutorial DAG', schedule='@daily', catchup=False):

        start = DummyOperator(task_id='DuStartOp')
        end = DummyOperator(task_id='DuEndOp', trigger_rule='none_failed')
        GetCurrentTRM = PythonOperator(task_id='GetCurrentTRM', python_callable=get_trm, retries=3)
        GetCurrentTime = PythonOperator(task_id='GetCurrentTime', python_callable=get_time, retries=3)
        GetJob = PythonOperator(task_id='GetJob', python_callable=get_job, retries=3)
        GetPersonName = PythonOperator(task_id='GetPersonName', python_callable=get_name, retries=3)
        GetPersonDescription = PythonOperator(task_id='GetPersonDescription', python_callable=get_personal_info, retries=3)
        GetPrint = PythonOperator(task_id='GetPrint', python_callable=get_print, retries=3)

        start >> GetCurrentTRM >> GetCurrentTime >> GetJob >> GetPersonName >> GetPersonDescription >> GetPrint >> end