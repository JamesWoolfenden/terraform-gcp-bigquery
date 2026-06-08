output "bigquery" {
  value       = module.bigquery
  description = "BigQuery moduledetails"
}

output "kms_key_ring" {
  value       = google_kms_key_ring.keyring
  description = "Key ring details"
}
