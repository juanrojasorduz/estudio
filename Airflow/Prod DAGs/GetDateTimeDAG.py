from airflow.operators.dummy import DummyOperator
from airflow import DAG
from datetime import datetime
from airflow.operators.python import PythonOperator
import pytz
from airflow.models import Variable

default_args = {
    'retries': 1,
}

def get_timezone(ti):
    timezone = Variable.get("timezone", default_var=None) # Set variable, ex: timezone = America/Bogota
    print(f'Timezone selected is {timezone}')
    ti.xcom_push("timezone", timezone)

def get_datetime(ti):
    timezone = ti.xcom_pull(key = 'timezone',task_ids = 'GetTimeZone')
    datetime_tz = pytz.timezone(timezone)
    datetime_tz = datetime.now(datetime_tz)
    datetime_tz = datetime_tz.strftime("%m/%d/%Y, %H:%M:%S")
    print(f'Datetime for TimeZone {timezone} is {datetime_tz}')

with DAG(dag_id='GetDateTimeDAG', start_date=datetime(2023, 1, 1), default_args=default_args, schedule='@daily', catchup=False):

    start = DummyOperator(task_id='DuStartOp')

    GetTimeZone = PythonOperator(task_id='GetTimeZone', python_callable=get_timezone)
    GetDateTime = PythonOperator(task_id='GetDateTime', python_callable=get_datetime)

    end = DummyOperator(task_id='DuEndOp', trigger_rule='none_failed')

    start >> GetTimeZone >> GetDateTime >> end