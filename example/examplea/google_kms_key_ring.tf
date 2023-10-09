resource "google_kms_key_ring" "keyring" {
  name     = var.key_ring_name
  project  = var.project
  location = var.location
}
