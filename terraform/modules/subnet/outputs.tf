output "subnet_id" {
  value       = aws_subnet.poc_subnet.id
  description = "The corresponding generated id when the subnet has been created"
}   