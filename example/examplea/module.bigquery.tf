module "bigquery" {
  source = "../../"
  table = {
    table_id = "sheet"
    external_data_configuration = {
      autodetect    = true
      source_format = "GOOGLE_SHEETS"
      google_sheets_options = {
        skip_leading_rows = 1
      }
      source_uris = [
        "https://docs.google.com/spreadsheets/d/123456789012345",
      ]
    }
  }
  dataset = {
    dataset_id                  = "foo"
    friendly_name               = "test"
    description                 = "This is a test description"
    default_table_expiration_ms = 3600000
  }
  location = var.location
  keyring  = google_kms_key_ring.keyring

  job = {
    job_id               = "job_query"
    query                = "SELECT state FROM [lookerdata:cdc.project_tycho_reports]"
    allow_large_results  = true
    flatten_results      = true
    key_result_statement = "LAST"
  }

  labels = {
    pike = "permissions"
  }
  deletion_protection = false
  key_users = [
    "serviceAccount:service-${data.google_project.current.number}@gcp-sa-pubsub.iam.gserviceaccount.com",
  ]
}

data "google_project" "current" {}
