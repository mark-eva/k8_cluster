output "sec_group_id" {
  value       = aws_security_group.poc_sec_group.id
  description = "The corresponding generated id when the subnet has been created"
}

