resource "google_bigquery_job" "example" {
  job_id = var.job.job_id

  query {
    query = var.job.query

    destination_table {
      project_id = google_bigquery_table.example.project
      dataset_id = google_bigquery_table.example.dataset_id
      table_id   = google_bigquery_table.example.table_id
    }

    allow_large_results = var.job.allow_large_results
    flatten_results     = var.job.flatten_results

    script_options {
      key_result_statement = var.job.key_result_statement
    }
  }

  #cant be set 11/2/2022
  # destination_encryption_configuration {
  #     kms_key_name=google_kms_crypto_key.example.name
  # }
}

variable "job" {
  type = object({
    job_id              = string
    query               = string
    allow_large_results = bool
    flatten_results     = bool


    key_result_statement = string

  })
}