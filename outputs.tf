output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_ssm_parameter.vpc.id
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = aws_ssm_parameter.public_subnets[*].id
}
output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = aws_ssm_parameter.private_subnets[*].id
}
output "database_subnets" {
  description = "The IDs of the database subnets"
  value       = aws_ssm_parameter.database_subnets[*].id
}