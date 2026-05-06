# terraform-gcp-bigquery

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-bigquery/workflows/Verify/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-bigquery)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-bigquery.svg)](https://github.com/JamesWoolfenden/terraform-gcp-bigquery/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-gcp-bigquery.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-gcp-bigquery/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.14.0-blue.svg)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/JamesWoolfenden/terraform-gcp-bigquery/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-gcp-bigquery&benchmark=CIS+AWS+V1.2)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/jameswoolfenden/terraform-gcp-bigquery/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-gcp-bigquery&benchmark=INFRASTRUCTURE+SECURITY)

The beginnings of a bigquery module for GCP, now with compute firewall options.
The bigquery is designed to work primarily with a private Kubernetes Cluster and is enabled for OS Logins. You'll need to add the service role an OS role to your users they will be able to SSH into it.
Basic Kubernetes tools are also installed into the bigquery by **default**.

2 examples are included, one with and one without a static IP.
To find the image family and project:

```cli
gcloud compute images list
```

```cli
gcloud kms locations list
gcloud kms keyrings create --location=europe-west1 examplea
```

## Usage

Add **module.bigquery.tf** to your code:-

```terraform
module "bigquery" {
  source             = "JamesWoolfenden/bigquery/gcp"
  version            = "0.1.13"
  image              = var.image
  name               = var.name
  network_interface  = var.network_interface
  service_email      = var.service_email
  source_cidrs       = var.source_cidrs
  zone               = var.zone
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_bigquery_dataset.example](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |
| [google_bigquery_job.example](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_job) | resource |
| [google_bigquery_table.example](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |
| [google_kms_crypto_key.example](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_binding.crypto_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_dataset"></a> [dataset](#input\_dataset) | n/a | <pre>object({<br/>    dataset_id                  = string<br/>    friendly_name               = string<br/>    description                 = string<br/>    default_table_expiration_ms = number<br/>  })</pre> | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | n/a | `bool` | `true` | no |
| <a name="input_job"></a> [job](#input\_job) | n/a | <pre>object({<br/>    job_id              = string<br/>    query               = string<br/>    allow_large_results = bool<br/>    flatten_results     = bool<br/><br/><br/>    key_result_statement = string<br/><br/>  })</pre> | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `string` | `"crypto-key-example"` | no |
| <a name="input_key_users"></a> [key\_users](#input\_key\_users) | (optional) describe your variable | `list(string)` | n/a | yes |
| <a name="input_keyring"></a> [keyring](#input\_keyring) | n/a | `any` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | (optional) describe your variable | `map(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_table"></a> [table](#input\_table) | n/a | <pre>object({<br/>    table_id = string<br/>    external_data_configuration = object({<br/>      autodetect    = bool<br/>      source_format = string<br/>      google_sheets_options = object({<br/>        skip_leading_rows = number<br/>      })<br/>      source_uris = list(string)<br/>    })<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Role and Permissions

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang

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


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Information

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang

resource "google_project_iam_custom_role" "terraform_pike" {
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "bigquery.datasets.create",
    "bigquery.jobs.create",
    "cloudkms.cryptoKeyVersions.destroy",
    "cloudkms.cryptoKeyVersions.list",
    "cloudkms.cryptoKeys.create",
    "cloudkms.cryptoKeys.get",
    "cloudkms.cryptoKeys.update"
  ]
}


```
