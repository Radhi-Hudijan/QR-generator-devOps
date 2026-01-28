terraform {
  backend "s3" {
    bucket         = "qr-generator-devops-terraform-state-backend-${terraform.workspace}"
    key            = "terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "qr-generator-devops-terraform-locks"

  }
}

