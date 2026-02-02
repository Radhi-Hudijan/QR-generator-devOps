terraform {
  backend "s3" {
    bucket = "qr-generator-devops-terraform-state-backend"
    key    = "vpc/terraform.tfstate"
    region = "eu-central-1"

  }
}

