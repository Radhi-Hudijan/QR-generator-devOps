terraform {
  backend "s3" {
    bucket = "qr-generator-devops-terraform-state-backend"
    key    = "eks/terraform.tfstate"
    region = "eu-central-1"

  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "qr-generator-devops-terraform-state-backend"
    key    = "env:/dev/vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "${local.default_tags.project}-eks"
  kubernetes_version = "1.33"

  # EKS Addons
  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnet_ids

  eks_managed_node_groups = {
    qr_code_group = {
      instance_types = ["t3.medium"]
      min_size       = 2
      max_size       = 5
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 2

    }
  }

  tags = local.default_tags
}
