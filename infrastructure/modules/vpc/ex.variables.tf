# VPC Module Variables

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

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) > 0 && length(var.public_subnet_cidrs) <= 4
    error_message = "Must have between 1 and 4 public subnets."
  }
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) > 0 && length(var.private_subnet_cidrs) <= 4
    error_message = "Must have between 1 and 4 private subnets."
  }
}

variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= length(var.public_subnet_cidrs) && length(var.availability_zones) >= length(var.private_subnet_cidrs)
    error_message = "Must have enough availability zones for all subnets."
  }
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform = "true"
    ManagedBy = "Terraform"
  }
}
