resource "google_bigquery_table" "example" {
  dataset_id = google_bigquery_dataset.example.dataset_id
  table_id   = var.table.table_id

  external_data_configuration {
    autodetect    = var.table.external_data_configuration.autodetect
    source_format = var.table.external_data_configuration.source_format

    google_sheets_options {
      skip_leading_rows = var.table.external_data_configuration.google_sheets_options.skip_leading_rows
    }

    source_uris = var.table.external_data_configuration.source_uris
  }
  encryption_configuration {
    kms_key_name = google_kms_crypto_key.example.name
  }
  deletion_protection = var.deletion_protection

  labels = var.labels
}
