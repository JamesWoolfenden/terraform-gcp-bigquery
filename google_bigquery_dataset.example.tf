
resource "google_bigquery_dataset" "example" {
  dataset_id                  = var.dataset.dataset_id
  friendly_name               = var.dataset.friendly_name
  description                 = var.dataset.description
  location                    = var.location
  default_table_expiration_ms = var.dataset.default_table_expiration_ms

  default_encryption_configuration {
    kms_key_name = google_kms_crypto_key.example.name
  }
}


variable "dataset" {
  type = object({
    dataset_id                  = string
    friendly_name               = string
    description                 = string
    default_table_expiration_ms = number
  })
}