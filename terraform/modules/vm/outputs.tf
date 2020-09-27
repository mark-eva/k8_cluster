output "vm_id" {
  value       = aws_instance.vm.id
  description = "instance id of the vm"

}

output "public_ip" {
  value       = aws_instance.vm.public_ip
  description = "instance id of the vm"

}