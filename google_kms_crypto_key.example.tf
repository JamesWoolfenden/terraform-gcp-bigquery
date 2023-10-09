resource "google_kms_crypto_key" "example" {
  #checkov:skip=CKV_GCP_82: make modification via tf impossible
  name            = var.key_name
  key_ring        = var.keyring.name
  rotation_period = "100000s"

  labels = var.labels
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.example.id
  role          = "roles/cloudkms.cryptoKeyEncrypter"

  members = var.key_users
}
