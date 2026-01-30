terraform {
  backend "s3" {
    bucket         = "qr-generator-devops-terraform-state-backend-dev"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "qr-generator-devops-terraform-locks"

  }
}

