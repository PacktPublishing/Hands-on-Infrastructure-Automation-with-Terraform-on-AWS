variable "environment" {
  type    = "string"
  default = "test"
}

variable "s3_bucket_prefix" {
  type        = "string"
  description = "Prefix of the S3 bucket"
}

variable "s3_region" {
  type = "string"
}

locals {
  s3_tags = {
    created_by  = "terraform"
    environment = "test"
  }
}
