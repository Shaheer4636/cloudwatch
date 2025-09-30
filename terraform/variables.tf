variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "sandbox"
}

variable "appname" {
  description = "Application name"
  type        = string
  default     = "PlatformEng"
}

variable "vpccidr" {
  description = "VPC CIDR for sandbox"
  type        = string
  # Ryan’s /24 block
  default     = "172.18.48.0/24"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "rds_aurora_postgresql_engine_version" {
  description = "Aurora PostgreSQL engine version"
  type        = string
  default     = "16.2" # adjust if your param group expects 16.x
}
