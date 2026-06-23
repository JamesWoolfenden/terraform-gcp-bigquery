
variable "project" {
  type        = string
  description = "GCP project ID where resources will be created."

  validation {
    condition     = length(trimspace(var.project)) > 0
    error_message = "The project variable must be provided and cannot be empty."
  }
}

variable "key_ring_name" {
  type        = string
  default     = "crypto-key-example"
  description = "Name of the Cloud KMS key ring to create or use."

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.key_ring_name)) && length(var.key_ring_name) > 0
    error_message = "The key_ring_name must contain only lowercase letters, numbers and hyphens."
  }
}

variable "location" {
  type        = string
  default     = "europe-west2"
  description = "GCP region for resources (e.g. europe-west2)"

  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]+$", var.location)) && length(var.location) > 0
    error_message = "The location must be a valid GCP region token like 'europe-west2'."
  }
}
