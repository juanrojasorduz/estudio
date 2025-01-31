from airflow import DAG
from airflow.decorators import task
from datetime import datetime

with DAG('dag_xcoms_example', start_date=datetime(2022, 1, 1), schedule_interval='@daily', catchup=False):
	@task
	def peter_task(ti=None):
		return 'iphone'
		
	@task
	def bryan_task(mobile_phone):
		print(mobile_phone)
	
	bryan_task(peter_task())