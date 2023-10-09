output "bigquery" {
  value = module.bigquery
}

output "kms_key_ring" {
  value = google_kms_key_ring.keyring
}
