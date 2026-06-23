
# holden:ignore:HLD_GCP_019 — labels are inherited from the provider's default_labels
resource "google_bigquery_dataset" "pike" {
  project                     = var.project
  dataset_id                  = var.dataset.dataset_id
  friendly_name               = var.dataset.friendly_name
  description                 = var.dataset.description
  location                    = var.location
  default_table_expiration_ms = var.dataset.default_table_expiration_ms

  default_encryption_configuration {
    kms_key_name = google_kms_crypto_key.bigquery.name
  }
}
