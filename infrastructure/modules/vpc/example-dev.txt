# VPC Module - Development Environment Example

module "vpc_dev" {
  source = "../modules/vpc"

  environment = "dev"
  vpc_cidr    = "10.0.0.0/16"

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]

  availability_zones = ["us-east-1a", "us-east-1b"]

  common_tags = {
    Environment = "dev"
    Project     = "QR-Generator"
    Terraform   = "true"
    ManagedBy   = "Terraform"
  }
}

output "dev_vpc_id" {
  value = module.vpc_dev.vpc_id
}

output "dev_public_subnets" {
  value = module.vpc_dev.public_subnet_ids
}

output "dev_private_subnets" {
  value = module.vpc_dev.private_subnet_ids
}
