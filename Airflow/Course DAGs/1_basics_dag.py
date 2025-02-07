from airflow import DAG  ## Import DAG to define Dag
from datetime import datetime ## Import datetime
from airflow.operators.python import PythonOperator ## Import PythonOperator
from airflow.utils.helpers import chain

## dictionary that contains default parameters to be applied to tasks within a Directed Acyclic Graph (DAG)
default_args = {
    'retries': 3,
}

## print function that can be used for tasks
def print_a():
    print('hi from task a')

def print_b():
    print('hi from task b')

def print_c():
    print('hi from task c')

def print_d():
    print('hi from task d')

def print_e():
    print('hi from task e')

## DEFINE THE DAG AND THE TASKS
#context (with) Using context is better because you can create your tasks under the DAG object, without using dag parameter in each task 
#dag_id: Unique identifier for DAG
#start_date: date in which the dag will start scheduling the pipeline
#schedule: frequency in which the dag will be triggered
#catchup: Parameter that allows to avoid running non triggered past DAG runs from the start date to now 
#           or from the last time that your pipeline has been triggered and now.
#           this will avoid ending up with a total of dag runs running at the same time
#description:
#tags:
#
#
#
with DAG(dag_id='my_dag', start_date=datetime(2023, 1, 1), default_args=default_args,
         description='A sample tutorial DAG', schedule='@daily', catchup=False, tags=['data_science']):
    
    task_a = PythonOperator(task_id='task_a', python_callable=print_a, retries=3)
    task_b = PythonOperator(task_id='task_b', python_callable=print_b, retries=3)
    task_c = PythonOperator(task_id='task_c', python_callable=print_c, retries=3)
    task_d = PythonOperator(task_id='task_d', python_callable=print_d, retries=3)
    task_e = PythonOperator(task_id='task_e', python_callable=print_e, retries=3)

    ## Define the order in which the tasks will be executed (dependencies)

    # Option A
    task_a >> task_b >> task_c >> task_d >> task_e

    # Option B : It executes tasks b,c and d at the same time
    #task_a >> [task_b, task_c, task_d] >> task_e

    # Option C : It executes tasks in this order: a -> b -> d
    #                                             a -> c -> e
    #chain(task_a, [task_b, task_c], [task_d, task_e])
