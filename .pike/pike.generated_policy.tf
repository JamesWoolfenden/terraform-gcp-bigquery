
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "bigquery.datasets.create",
    "bigquery.datasets.delete",
    "bigquery.datasets.get",
    "bigquery.datasets.update",
    "bigquery.jobs.create",
    "bigquery.jobs.delete",
    "bigquery.jobs.get",
    "bigquery.jobs.update",
    "bigquery.tables.create",
    "bigquery.tables.delete",
    "bigquery.tables.get",
    "bigquery.tables.update",
    "cloudkms.cryptoKeyVersions.destroy",
    "cloudkms.cryptoKeyVersions.list",
    "cloudkms.cryptoKeys.create",
    "cloudkms.cryptoKeys.get",
    "cloudkms.cryptoKeys.getIamPolicy",
    "cloudkms.cryptoKeys.setIamPolicy",
    "cloudkms.cryptoKeys.update"
  ]
}
