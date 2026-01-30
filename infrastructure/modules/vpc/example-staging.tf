# VPC Module - Staging Environment Example

module "vpc_staging" {
  source = "../modules/vpc"

  environment = "staging"
  vpc_cidr    = "10.1.0.0/16"

  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  private_subnet_cidrs = ["10.1.10.0/24", "10.1.11.0/24", "10.1.12.0/24"]

  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  common_tags = {
    Environment = "staging"
    Project     = "QR-Generator"
    Terraform   = "true"
    ManagedBy   = "Terraform"
  }
}

output "staging_vpc_id" {
  value = module.vpc_staging.vpc_id
}

output "staging_public_subnets" {
  value = module.vpc_staging.public_subnet_ids
}

output "staging_private_subnets" {
  value = module.vpc_staging.private_subnet_ids
}
