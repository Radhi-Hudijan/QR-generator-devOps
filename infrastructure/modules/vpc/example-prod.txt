# VPC Module - Production Environment Example

module "vpc_prod" {
  source = "../modules/vpc"

  environment = "prod"
  vpc_cidr    = "10.2.0.0/16"

  public_subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
  private_subnet_cidrs = ["10.2.10.0/24", "10.2.11.0/24", "10.2.12.0/24"]

  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  common_tags = {
    Environment = "prod"
    Project     = "QR-Generator"
    Terraform   = "true"
    ManagedBy   = "Terraform"
  }
}

output "prod_vpc_id" {
  value = module.vpc_prod.vpc_id
}

output "prod_public_subnets" {
  value = module.vpc_prod.public_subnet_ids
}

output "prod_private_subnets" {
  value = module.vpc_prod.private_subnet_ids
}
