data "aws_caller_identity" "current" {}

data "aws_vpc" "cluster" {
  id = var.vpc_id
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.cluster.id]
  }

  filter {
    name   = "subnet-id"
    values = var.public_subnet_ids
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.cluster.id]
  }

  filter {
    name   = "subnet-id"
    values = var.private_subnet_ids
  }
}

data "aws_iam_openid_connect_provider" "openshift" {
  url = var.oidc_url
}
