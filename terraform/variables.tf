variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the Cluster"
  type        = string
  default     = "dscott"
}

# this can be obtained via rosa describe cluster -c <cluster_name>
variable "oidc_url" {
  description = "URL of OIDC provider"
  type        = string
}
