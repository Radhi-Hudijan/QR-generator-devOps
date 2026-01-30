variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = can(regex("^(dev|staging|prod)$", var.environment))
    error_message = "Environment must be dev, staging, or prod."
  }
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid CIDR block."
  }

}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = false

}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true

}

variable "tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default     = {}

}

###### IGW Variables ######
variable "create_igw" {
  description = "Whether to create an Internet Gateway"
  type        = bool
  default     = true

}

variable "igw_tags" {
  description = "Additional tags to apply to the Internet Gateway"
  type        = map(string)
  default     = {}

}

###### Public Subnet Variables ######

variable "public_subnets_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)

  validation {
    condition     = length(var.public_subnets_cidrs) > 0 && length(var.public_subnets_cidrs) <= 4
    error_message = "Must have between 1 and 4 public subnets."
  }

}

variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
  default     = []

}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IPs on launch for public subnets"
  type        = bool
  default     = false
}

variable "public_subnet_tags" {
  description = "Additional tags to apply to public subnets"
  type        = map(string)
  default     = {}

}

###### route table variables ######
variable "public_route_table_tags" {
  description = "Additional tags to apply to public route tables"
  type        = map(string)
  default     = {}

}

