locals {
  default_tags = {
    project     = "qr-generator-devOps"
    Owner       = "radhi.hudijan"
    Environment = "${terraform.workspace}-environment"
    ManagedBy   = "Terraform"
  }

  aws_region = "eu-central-1"

  prov
  
}
