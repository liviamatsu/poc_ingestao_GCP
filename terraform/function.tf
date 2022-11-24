# Gerando um arquivo do código-fonte compactado como um arquivo .zip.

data "archive_file" "source" {
    type        = "zip"
    source_dir  = "../src"
    output_path = "/tmp/function.zip"
}

# Adicionar o código-fonte zip ao bucket do Cloud Function
resource "google_storage_bucket_object" "zip" {
    source       = data.archive_file.source.output_path
    content_type = "application/zip"

# Anexa à soma de verificação MD5 do conteúdo dos arquivos
# para forçar o zip a ser atualizado assim que ocorrer uma mudança

    name         = "src-${data.archive_file.source.output_md5}.zip"
    bucket       = google_storage_bucket.function_bucket.name

    # As dependências são inferidas automaticamente para que essas linhas possam ser excluídas
    depends_on   = [
        google_storage_bucket.function_bucket,  # declared in `storage.tf`
        data.archive_file.source
    ]
}

# Crie a função Cloud acionada por um evento `Finalize` no bucket

resource "google_cloudfunctions_function" "function" {
    name                  = "function-trigger-on-gcs"
    runtime               = "python37"  
    

    # Obtenha o código-fonte da função de nuvem como uma compactação Zip

    source_archive_bucket = google_storage_bucket.function_bucket.name
    source_archive_object = google_storage_bucket_object.zip.name

    # Deve corresponder ao nome da função no código-fonte `main.py` da função de nuvem
    
    entry_point           = "pocA3Data_gcs"
    
    # 
    event_trigger {
        event_type = "google.storage.object.finalize"
        resource   = "${var.project_id}-input"
    }

    # As dependências são inferidas automaticamente para que essas linhas possam ser excluídas
    depends_on            = [
        google_storage_bucket.function_bucket,  # declarado em `storage.tf``
        google_storage_bucket_object.zip
    ]
}