# Wiring happens in the per-resource files. This file is intentionally minimal.
terraform {
  # Your backend might be configured by the pipeline template. If not,
  # uncomment and fill S3 backend here.
  # backend "s3" {
  #   bucket = "devopssandbox-tfstate"
  #   key    = "platformeng/rds-aurora/terraform.tfstate"
  #   region = "us-east-1"
  # }
}
