output "controller_role_arn" {
  description = "Role ARN for AWS Load Balancer Controller role"
  value       = aws_iam_role.controller.arn
}
