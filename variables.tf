
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
}

variable "key_name" {
  type    = string
  default = "crypto-key-example"
}

variable "location" {
  type = string
}

variable "keyring" {
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = ""
}

variable "job" {
  type = object({
    job_id              = string
    query               = string
    allow_large_results = bool
    flatten_results     = bool


    key_result_statement = string

  })
}

variable "dataset" {
  type = object({
    dataset_id                  = string
    friendly_name               = string
    description                 = string
    default_table_expiration_ms = number
  })
}

variable "labels" {
  type        = map(string)
  description = "(optional) describe your variable"
}

variable "key_users" {
  type        = list(string)
  description = "(optional) describe your variable"
}
