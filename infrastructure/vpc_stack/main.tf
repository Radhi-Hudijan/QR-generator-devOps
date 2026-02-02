## VPC Stack ##
module "vpc" {
  source      = "../modules/vpc"
  environment = local.default_tags.Environment

  vpc_cidr = "10.0.0.0/20"

  enable_dns_hostnames = true
  enable_dns_support   = true

  availability_zones = ["eu-central-1a", "eu-central-1a", "eu-central-1b", "eu-central-1b"]
  tags               = local.default_tags

  public_subnet_cidrs = ["10.0.0.0/22", "10.0.4.0/22", "10.0.8.0/22", "10.0.12.0/22"]

  map_public_ip_on_launch = true

}


output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}


