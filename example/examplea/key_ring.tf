resource "google_kms_key_ring" "keyring" {
  name     = var.key_ring_name
  project  = var.project
  location = var.location
}

variable "key_ring_name" {
  type    = string
  default = "crypto-key-example"
}

variable "location" {
  type    = string
  default = "europe-west2"
}


