resource "google_kms_crypto_key" "example" {
  #checkov:skip=CKV_GCP_82: make modification via tf impossible
  name            = var.key_name
  key_ring        = var.keyring.name
  rotation_period = "100000s"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.example.id
  role          = "roles/cloudkms.cryptoKeyEncrypter"

  members = var.key_users
}

# BigQuery's service agent must be able to both encrypt and decrypt with this
# key for CMEK to work; Google does not grant this automatically, so the module
# declares it explicitly, scoped to this single key, rather than leaving it to
# be granted out-of-band at the key ring or project level.
data "google_bigquery_default_service_account" "example" {
  project = var.project
}

resource "google_kms_crypto_key_iam_member" "bigquery_service_agent" {
  crypto_key_id = google_kms_crypto_key.example.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${data.google_bigquery_default_service_account.example.email}"
}

resource "google_kms_crypto_key_iam_member" "decrypters" {
  for_each = toset(var.key_decrypters)

  crypto_key_id = google_kms_crypto_key.example.id
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  member        = each.value
}
