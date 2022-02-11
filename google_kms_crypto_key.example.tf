resource "google_kms_crypto_key" "example" {
  name            = var.key_name
  key_ring        = var.keyring.name
  rotation_period = "100000s"

  lifecycle {
    prevent_destroy = true
  }
}


