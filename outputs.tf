output "kms_key" {
  value       = google_kms_crypto_key.example
  description = "Key details"
}

output "dataset" {
  value       = google_bigquery_dataset.example
  description = "BigQuery dataset details"
}

output "table" {
  value       = google_bigquery_table.example
  description = "BigQuery table details"
}

output "job" {
  value       = google_bigquery_job.example
  description = "BigQuery job details"
}
