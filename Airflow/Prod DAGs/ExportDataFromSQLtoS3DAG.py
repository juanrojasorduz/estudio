from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.operators.dummy import DummyOperator
from airflow import DAG
from datetime import datetime
from airflow.providers.amazon.aws.transfers.sql_to_s3 import SqlToS3Operator

default_args = {
    'retries': 1,
}

with DAG(dag_id='ExportDataFromSQLtoS3DAG', start_date=datetime(2023, 1, 1), default_args=default_args, schedule='@daily', catchup=False):

    start = DummyOperator(task_id='DuStartOp')

    drop_table_if_exists = SQLExecuteQueryOperator(
        task_id="DropTableIfExists",
        conn_id="mssql_default",
        sql=r"""
        DROP TABLE IF EXISTS master.dbo.Country;
        """
    )    

    create_table = SQLExecuteQueryOperator(
        task_id="CreateTable",
        conn_id="mssql_default",
        sql=r"""
        CREATE TABLE Country (
            country_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
            name TEXT,
            continent TEXT
        );
        """
    )

    insert_records_in_table = SQLExecuteQueryOperator(
        task_id="InsertRecordsInTable",
        conn_id="mssql_default",
        sql=r"""
                INSERT INTO Country (name, continent)
                VALUES ( 'Colombia', 'America');
                INSERT INTO Country (name, continent)
                VALUES ( 'Alemania', 'Europa');
                INSERT INTO Country (name, continent)
                VALUES ( 'Nigeria', 'Africa');
                INSERT INTO Country (name, continent)
                VALUES ( 'China', 'Asia');
                """
    )

    export_data_to_s3 = SqlToS3Operator(
        task_id="ExportDataToS3",
        sql_conn_id="mssql_default",
        aws_conn_id="aws_s3",
        query="SELECT * FROM master.dbo.Country;",
        s3_bucket="bucketfordatajds3",
        s3_key="airflow/countries.csv",
        replace=True
    )

    end = DummyOperator(task_id='DuEndOp', trigger_rule='none_failed')

    start >> drop_table_if_exists >> create_table >> insert_records_in_table >> export_data_to_s3 >> end