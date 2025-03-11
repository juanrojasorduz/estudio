from airflow import DAG
from airflow.providers.cncf.kubernetes.operators.kubernetes_pod import KubernetesPodOperator
from airflow.decorators import task
from datetime import datetime

with DAG(
    dag_id="share_pod_dag",
    start_date=datetime(2022, 1, 1),
    schedule="@once",
    catchup=False
):
    
    @task
    def push_data():
        return 100
    
    run_simple_app = KubernetesPodOperator(
        task_id="run_simple_app",
        namespace="default",
        image="localhost:5000/simple_app",
        name="airflow-test-pod",
        env_vars={"DATA_POINT": """{{ ti.xcom_pull(task_ids='push_data') }}"""},
        do_xcom_push=True,
        in_cluster=False,
        cluster_context="docker-desktop",
        config_file="/usr/local/airflow/include/.kube/config",
        is_delete_operator_pod=False,
        get_logs=True,
        log_events_on_failure=False
    )
    
    @task
    def pull_data(ti=None):
        print(ti.xcom_pull(task_ids='run_simple_app'))
        
    push_data() >> run_simple_app >> pull_data()