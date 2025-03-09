from airflow import DAG
from airflow.providers.cncf.kubernetes.operators.kubernetes_pod import KubernetesPodOperator
from datetime import datetime

with DAG(
    dag_id="pod_dag",
    start_date=datetime(2022, 1, 1),
    schedule="@once",
    catchup=False
):
    KubernetesPodOperator(
        task_id="print_message",
        namespace="default",
        image="hello-world",
        name="airflow-test-pod",
        in_cluster=False,
        cluster_context="docker-desktop",
        config_file="/usr/local/airflow/include/.kube/config",
        is_delete_operator_pod=True,
        get_logs=True
    )