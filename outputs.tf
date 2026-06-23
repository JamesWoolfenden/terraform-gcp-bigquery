output "kms_key" {
  value       = google_kms_crypto_key.bigquery
  description = "Key details"
}

output "dataset" {
  value       = google_bigquery_dataset.pike
  description = "BigQuery dataset details"
}

output "table" {
  value       = google_bigquery_table.pike
  description = "BigQuery table details"
}

output "job" {
  value       = google_bigquery_job.pike
  description = "BigQuery job details"
}
