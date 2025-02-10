variable "credentials" {
  description = "Credentials to GCP"
  default     = "./keys/key.json"
}

variable "project_id" {
  description = "GCP Proyect"
  default     = "data-engineer-zoomcamp-450513"
}

variable "region" {
  description = "Region of Proyect"
  default     = "us-central1"
}

variable "gcp_bucket_name" {
  description = "Name of bucket in GCP"
  default     = "data-engineer-zoomcamp-450513-data-lake-bucket"
}

variable "location" {
  description = "Location of the proyect"
  default     = "US"
}

variable "gcs_bucket_storage_class" {
  description = "GCS Storage Class"
  default     = "STANDARD"
}

variable "bq_dataset_name" {
    description = "Big Query Dataset Name"
    default = "terrademo_dataset"
  
}