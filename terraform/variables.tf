variable "credentials" {
  description = "My Credentials"
  default     = "./keys/my-creds.json"
}

variable "project" {
  description = "Project ID"
  default     = "arcane-attic-412509"
}

variable "region" {
  description = "Project Region"
  default     = "europe-west3"
}

variable "location" {
  description = "Project Location"
  default     = "EU"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "ny_taxi"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "arcane-attic-412509-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}