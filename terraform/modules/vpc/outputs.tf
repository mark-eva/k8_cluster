output "vpc_id" {
  value       = aws_vpc.template.id
  description = "ID of the VPC"
}