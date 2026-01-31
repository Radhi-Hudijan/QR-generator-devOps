locals {
  default_tags = {
    project     = "qr-generator-devOps"
    Owner       = "radhi.hudijan"
    Environment = "${terraform.workspace}"
    ManagedBy   = "Terraform"
  }

  aws_region = "eu-central-1"

}
