resource "google_bigquery_table" "pike" {
  dataset_id = google_bigquery_dataset.pike.dataset_id
  project    = var.project
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
    kms_key_name = google_kms_crypto_key.bigquery.name
  }
  deletion_protection = var.deletion_protection
}
