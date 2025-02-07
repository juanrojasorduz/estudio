from airflow.operators.dummy import DummyOperator
from airflow.operators.bash import BashOperator
from airflow import DAG
from datetime import datetime
from airflow.sensors.filesystem import FileSensor

default_args = {
    'retries': 1,
}

with DAG(dag_id='GetFileContentDAG', start_date=datetime(2023, 1, 1), default_args=default_args, schedule='@daily', catchup=False):

    start = DummyOperator(task_id='DuStartOp')
    
    # Define the FileSensor to wait for the file in the bash directory
    file_sensor = FileSensor(
        task_id='FileSensor',
        filepath='/usr/local/airflow/files/example.txt',  # Path to your file
        fs_conn_id='fs_default',  # Create Filesystem connection (local file system | conn_id = 'fs_default' | conn_type = 'File (path)')
        poke_interval=60,  # Time in seconds to wait between checks
        timeout=600,  # Max time to wait before failing (in seconds)
        mode='poke'  # Use 'poke' mode, or 'reschedule' depending on your preference
    )
    # BashOperator to print the content of file.txt
    print_file_content = BashOperator(
        task_id='PrintFileContent',
        bash_command='cat /usr/local/airflow/files/example.txt'
    )

    end = DummyOperator(task_id='DuEndOp', trigger_rule='none_failed')

    start >> file_sensor >> print_file_content >> end