provider "aws" {
  region = var.region
  # Credentials are provided by the Azure DevOps AWS service connection at runtime.
}
