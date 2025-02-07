from airflow import DAG  ## Import DAG to define Dag
from datetime import datetime ## Import datetime
from airflow.operators.python import PythonOperator ## Import PythonOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.task_group import TaskGroup

source_db = 'CLEANSED'
source_schema = 'SAP'
object_list = ['ZEXI_PRCD_ELEMENTS','ZEXI_INTERNALORDER','ZEXI_DELIVERYDOCUMENTTYPE']
replication_key = 'CREATED_DATE'

dag = DAG(dag_id='SFODSIncrGroup19',
          description='Moving data from SF to SQL Server',
          schedule_interval='@daily',
          start_date=datetime(2025, 1, 6),
          catchup=False)

def snow_export_query_count_gen(tablename: str, xcom_hwm_value: str, replication_key: str):
    basequery = 'SELECT count(*) FROM '
    query = base_query + f"{tablename} WHERE {replication_key} > '{xcom_hwm_value}'"
    return query

def snow_export_query_gen(tablename: str, xcom_hwm_value: str, replication_key: str):
    basequery = 'SELECT * FROM '
    query = base_query + f"{tablename} WHERE {replication_key} > '{xcom_hwm_value}'"
    return query

with dag:
    start = DummyOperator(task_id='DuStartOp')
    end = DummyOperator(task_id='DuEndOp')
    for obj in object_list:
        xcom_hwm_value = f'{datetime.now().strftime("%Y%m%d%H%M")}'
        tablename = f'{source_db}.{source_schema}.{obj}'
        with TaskGroup(f'Snow_Export_Load{obj}', prefix_group_id=False) as TG_Snow_Export_Load:
            upper_callable_params = {'tablename': f'{tablename}', 'xcom_hwm_value': f'{xcom_hwm_value}', 'replication_key': f'{replication_key}'}
            generate_query = PythonOperator(task_id=f'GenerateQueryOp{obj}', python_callable=snow_export_query_gen, provide_context=True, op_kwargs=upper_callable_params )
            generate_query_count = PythonOperator(task_id=f'GenerateQueryCountOp{obj}', python_callable=snow_export_query_count_gen, provide_context=True, op_kwargs=upper_callable_params )
            generate_query >> generate_query_count
        with TaskGroup(f'Snow_Export_Load_Duplicate{obj}', prefix_group_id=False) as TG_Snow_Export_Load_Duplicate:
            upper_callable_params = {'tablename': f'{tablename}', 'xcom_hwm_value': f'{xcom_hwm_value}', 'replication_key': f'{replication_key}'}
            generate_query = PythonOperator(task_id=f'GenerateQueryOpDuplicate{obj}', python_callable=snow_export_query_gen, provide_context=True, op_kwargs=upper_callable_params )
            generate_query_count = PythonOperator(task_id=f'GenerateQueryCountOpDuplicate{obj}', python_callable=snow_export_query_count_gen, provide_context=True, op_kwargs=upper_callable_params )
            generate_query >> generate_query_count

        start >> TG_Snow_Export_Load  >> TG_Snow_Export_Load_Duplicate >> end