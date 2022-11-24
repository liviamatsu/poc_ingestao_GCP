import os
from google.cloud import bigquery

"""
    Função para carregar os arquivos que estão no GCS para o BigQuery
    """
def pocA3Data_gcs(event, context):
    try:
        # instancia o cliente do bigquery
        bigquery_client = bigquery_Client()
    except Exception as ex:
        log.error(ex)
        logger.log_struct(
            {
                "Grupo_Log": log_group,
                "Status_Execucao": "Erro",
                "Nome_Job": job_name,
                "Dataset": dataset,
                "Tabela": table,
                "Inicio": start_time,
                "Fim": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                "Msg_Erro": str(ex),
            },
            resource=res,
            severity="ERROR",
        )
        error_client.report_exception()
