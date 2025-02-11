from airflow.providers.amazon.aws.sensors.s3 import S3KeySensor
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.providers.amazon.aws.transfers.s3_to_sql import S3ToSqlOperator
from airflow.operators.dummy import DummyOperator
from airflow import DAG
from datetime import datetime
import csv

default_args = {
    'retries': 1,
}

SQL_TABLE_NAME = "master.dbo.CountryTarget"
SQL_COLUMN_LIST = ["country_id", "name", "continent"]

def parse_csv_to_list(filepath):
    with open(filepath, newline="") as file:
        next(file)
        return list(csv.reader(file))

with DAG(dag_id='ExportDataFromS3toSqlDAG', start_date=datetime(2023, 1, 1), default_args=default_args, schedule='@daily', catchup=False):

    start = DummyOperator(task_id='DuStartOp')

    drop_table_if_exists = SQLExecuteQueryOperator(
        task_id="DropTableIfExists",
        conn_id="mssql_default",
        sql=f'DROP TABLE IF EXISTS {SQL_TABLE_NAME};'
    )

    create_table = SQLExecuteQueryOperator(
        task_id="CreateTable",
        conn_id="mssql_default",
        sql=f"""
        CREATE TABLE {SQL_TABLE_NAME} (
            country_id INT,
            name TEXT,
            continent TEXT
        );
        """
    )

    sensor_for_file_in_bucket = S3KeySensor(
        task_id="SensorForFilesInBucket",
        aws_conn_id="aws_s3",
        bucket_key="s3://bucketfordatajds3/airflow_sensor/countries.csv",
        wildcard_match=True,
        timeout=600,
        mode='poke',
        poke_interval=60
    )

    transfer_s3_to_sql = S3ToSqlOperator(
        task_id="ExportDataToSql",
        s3_bucket="bucketfordatajds3",
        s3_key="airflow_sensor/countries.csv",
        table=SQL_TABLE_NAME,
        column_list=SQL_COLUMN_LIST,
        parser=parse_csv_to_list,
        sql_conn_id="mssql_default",
        aws_conn_id="aws_s3"
    )

    end = DummyOperator(task_id='DuEndOp', trigger_rule='none_failed')

    start >> drop_table_if_exists >> create_table >> sensor_for_file_in_bucket >> transfer_s3_to_sql >> end