from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.models import Variable
from datetime import datetime

def _ml_task(ml_parameter):
    print(ml_parameter)

with DAG('ml_dag', start_date=datetime(2022, 1, 1),
    schedule_interval='@daily', catchup=False) as dag:

    for ml_parameter in Variable.get('ml_model_parameters', deserialize_json=True)["param"]:
        PythonOperator(
            task_id=f'ml_task_{ml_parameter}',
            python_callable=_ml_task,
            op_kwargs={
                'ml_parameter': ml_parameter
            }
        )