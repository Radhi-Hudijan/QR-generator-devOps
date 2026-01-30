##########
# VPC 
##########

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_support
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-vpc - ${terraform.workspace}"
      environment = var.environment
    }
  )

}

############
# Internet Gateway
############

resource "aws_internet_gateway" "main" {
  count = var.create_igw && length(var.public_subnets_cidrs) > 0 ? 1 : 0

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    var.igw_tags,
    {
      Name = "${var.environment}-igw - ${terraform.workspace}"
    }
  )

}

########
#public Subnets
########

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    var.tags,
    var.public_subnet_tags,
    {
      Name = "${var.environment}-public-subnet-${count.index + 1} - ${terraform.workspace}"
      Type = "Public"
    }
  )

}

########
# create public route table
########

resource "aws_route_table" "public" {
  count  = length(var.public_subnets_cidrs) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    var.public_route_table_tags,
    {
      Name = "${var.environment}-public-rt - ${terraform.workspace}"
    }
  )

}

# Create route to Internet Gateway in public route table
resource "aws_route" "public_internet_access" {
  count                  = length(var.public_subnets_cidrs) > 0 && var.create_igw ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main[0].id
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}
