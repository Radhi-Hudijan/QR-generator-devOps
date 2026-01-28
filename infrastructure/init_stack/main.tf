terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

}


# Configure the AWS Provider
provider "aws" {
  region = local.aws_region
}

// This bucket is created to store Terraform state files
resource "aws_s3_bucket" "qr_generator_backend" {
  bucket = "qr-generator-devops-terraform-state-backend-${terraform.workspace}"
  tags   = local.default_tags
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.qr_generator_backend.id

  versioning_configuration {
    status = "Enabled"
  }
}
