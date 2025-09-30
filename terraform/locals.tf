locals {
  name = "${var.appname}-${var.env}"
  tags = {
    Application = var.appname
    Environment = var.env
    ManagedBy   = "AzureDevOps"
  }

  # Ryan’s subnets (exactly as provided)
  private_subnets  = ["172.18.48.0/27",  "172.18.48.32/27",  "172.18.48.64/27"]
  database_subnets = ["172.18.48.96/27", "172.18.48.128/27","172.18.48.160/27"]
  public_subnets   = ["172.18.48.192/28","172.18.48.208/28","172.18.48.224/28"]
}
