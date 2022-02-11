
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