resource "google_kms_crypto_key" "bigquery" {
  #checkov:skip=CKV_GCP_82: make modification via tf impossible
  # holden:ignore:HLD_GCP_019 — labels are inherited from the provider's default_labels
  name            = var.key_name
  key_ring        = var.keyring.name
  rotation_period = "100000s"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_member" "crypto_key" {
  for_each = toset(var.key_users)

  crypto_key_id = google_kms_crypto_key.bigquery.id
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  member        = each.value
}

# BigQuery's service agent must be able to both encrypt and decrypt with this
# key for CMEK to work; Google does not grant this automatically, so the module
# declares it explicitly, scoped to this single key, rather than leaving it to
# be granted out-of-band at the key ring or project level.
data "google_bigquery_default_service_account" "this" {
  project = var.project
}

resource "google_kms_crypto_key_iam_member" "bigquery_service_agent" {
  crypto_key_id = google_kms_crypto_key.bigquery.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${data.google_bigquery_default_service_account.this.email}"
}

resource "google_kms_crypto_key_iam_member" "decrypters" {
  for_each = toset(var.key_decrypters)

  crypto_key_id = google_kms_crypto_key.bigquery.id
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  member        = each.value
}
