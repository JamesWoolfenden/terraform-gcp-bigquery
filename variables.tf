variable "project" {
  type        = string
  description = "The GCP project ID in which the BigQuery dataset, table, job and KMS key are created."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project))
    error_message = "project must be a valid GCP project ID: 6-30 characters, lowercase letters, digits or hyphens, starting with a letter and not ending with a hyphen."
  }
}

variable "table" {
  type = object({
    table_id = string
    external_data_configuration = object({
      autodetect    = bool
      source_format = string
      google_sheets_options = object({
        skip_leading_rows = number
      })
      source_uris = list(string)
    })
  })

  description = "Configuration for the BigQuery table, including its ID and the external data source (Google Sheets) it reads from."

  validation {
    condition     = var.table.external_data_configuration.source_format == "GOOGLE_SHEETS"
    error_message = "table.external_data_configuration.source_format must be \"GOOGLE_SHEETS\" because this module always sets google_sheets_options."
  }

  validation {
    condition     = length(var.table.external_data_configuration.source_uris) > 0
    error_message = "table.external_data_configuration.source_uris must contain at least one URI."
  }

  validation {
    condition     = var.table.external_data_configuration.google_sheets_options.skip_leading_rows >= 0
    error_message = "table.external_data_configuration.google_sheets_options.skip_leading_rows must be 0 or greater."
  }
}

variable "key_name" {
  type        = string
  default     = "crypto-key-example"
  description = "The name to give the Cloud KMS crypto key used to encrypt the BigQuery dataset, table and job."

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,63}$", var.key_name))
    error_message = "key_name must be 1-63 characters long and contain only letters, numbers, hyphens and underscores."
  }
}

variable "location" {
  type        = string
  description = "The GCP location for the BigQuery dataset, e.g. \"EU\", \"US\" or a region such as \"europe-west1\"."

  validation {
    condition     = length(var.location) > 0
    error_message = "location must not be empty."
  }
}

variable "keyring" {
  type        = object({ name = string })
  description = "The Cloud KMS key ring that the crypto key is created in. Must expose a `name` attribute (e.g. a `google_kms_key_ring` resource or data source)."

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,63}$", var.keyring.name))
    error_message = "keyring.name must be 1-63 characters long and contain only letters, numbers, hyphens and underscores."
  }
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "Whether to enable deletion protection on the BigQuery table, preventing it from being destroyed via Terraform."
}

variable "job" {
  type = object({
    job_id              = string
    query               = string
    allow_large_results = bool
    flatten_results     = bool


    key_result_statement = string

  })

  description = "Configuration for the BigQuery query job that writes its results into the example table, including the query text and execution options."

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.job.job_id)) && length(var.job.job_id) <= 1024
    error_message = "job.job_id must be 1-1024 characters long and contain only letters, numbers, hyphens and underscores."
  }

  validation {
    condition     = length(trimspace(var.job.query)) > 0
    error_message = "job.query must not be empty."
  }

  validation {
    condition     = contains(["LAST", "FIRST_SELECT"], var.job.key_result_statement)
    error_message = "job.key_result_statement must be either \"LAST\" or \"FIRST_SELECT\"."
  }
}

variable "dataset" {
  type = object({
    dataset_id                  = string
    friendly_name               = string
    description                 = string
    default_table_expiration_ms = number
  })

  description = "Configuration for the BigQuery dataset, including its ID, friendly name, description and default table expiration."

  validation {
    condition     = can(regex("^[a-zA-Z0-9_]+$", var.dataset.dataset_id)) && length(var.dataset.dataset_id) <= 1024
    error_message = "dataset.dataset_id must be 1-1024 characters long and contain only letters, numbers and underscores."
  }

  validation {
    condition     = var.dataset.default_table_expiration_ms >= 3600000
    error_message = "dataset.default_table_expiration_ms must be at least 3600000 (1 hour), per the BigQuery API minimum."
  }
}

variable "key_users" {
  type        = list(string)
  description = "IAM members granted the `roles/cloudkms.cryptoKeyEncrypter` role on the CMEK that encrypts this module's resources. Each entry must be a valid GCP IAM member identifier, e.g. `serviceAccount:name@project.iam.gserviceaccount.com`, `user:name@example.com` or `group:name@example.com`."

  validation {
    condition = alltrue([
      for member in var.key_users : !contains(["allUsers", "allAuthenticatedUsers"], member)
    ])
    error_message = "key_users must not contain \"allUsers\" or \"allAuthenticatedUsers\" - that would grant encrypt access on the CMEK to anyone on the internet or any authenticated Google account."
  }
}

variable "key_decrypters" {
  type        = list(string)
  default     = []
  description = "Additional IAM members to grant the narrowly-scoped `roles/cloudkms.cryptoKeyDecrypter` role on the CMEK, on top of the BigQuery service agent that this module grants automatically (it needs encrypt+decrypt for CMEK to function). Each entry must be a valid GCP IAM member identifier, e.g. `serviceAccount:name@project.iam.gserviceaccount.com`, `user:name@example.com` or `group:name@example.com`."

  validation {
    condition = alltrue([
      for member in var.key_decrypters : !contains(["allUsers", "allAuthenticatedUsers"], member)
    ])
    error_message = "key_decrypters must not contain \"allUsers\" or \"allAuthenticatedUsers\" - that would grant decrypt access on the CMEK to anyone on the internet or any authenticated Google account."
  }
}
