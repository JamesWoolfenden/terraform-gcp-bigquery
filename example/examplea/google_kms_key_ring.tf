resource "google_kms_key_ring" "keyring" {
  name     = var.key_ring_name
  location = var.location
  project  = var.project
}
