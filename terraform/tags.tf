resource "aws_ec2_tag" "cluster" {
  resource_id = data.aws_vpc.cluster.id
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "owned"
}

resource "aws_ec2_tag" "public_subnets" {
  for_each = toset(data.aws_subnets.public.ids)

  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = ""
}

resource "aws_ec2_tag" "private_subnets" {
  for_each = toset(data.aws_subnets.private.ids)

  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = ""
}
