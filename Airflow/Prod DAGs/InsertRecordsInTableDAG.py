from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.operators.dummy import DummyOperator
from airflow import DAG
from datetime import datetime

default_args = {
    'retries': 1,
}

with DAG(dag_id='InsertRecordsInTableDAG', start_date=datetime(2023, 1, 1), default_args=default_args, schedule='@daily', catchup=False):

    start = DummyOperator(task_id='DuStartOp')

    create_table_country = SQLExecuteQueryOperator(
        task_id="CreateTableCountry",
        conn_id="mssql_default",
        sql=r"""
        CREATE TABLE Country (
            country_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
            name TEXT,
            continent TEXT
        );
        """
    )

    insert_countries_table = SQLExecuteQueryOperator(
        task_id="InsertCountriesTable",
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

    end = DummyOperator(task_id='DuEndOp', trigger_rule='none_failed')

    start >> create_table_country >> insert_countries_table >> end