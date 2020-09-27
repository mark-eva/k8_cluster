output "vpc_id" {
  value = module.poc_vpc.vpc_id
}

output "subnet_id" {
  value       = module.poc_subnet.subnet_id
  description = "subnet id generated once the resource has been created"
}

output "sec_group_id" {
  value       = module.poc_sec_group.sec_group_id
  description = "subnet id generated once the resource has been created"
}

output "vm_id" {
  value       = module.db1.vm_id
  description = "vm instance id upon resource creation"
}


output "gateway_id" {
  value       = aws_internet_gateway.poc_gateway.id
  description = "gateway id"
}

output "public_ip" {
  value = module.db1.public_ip
}


output "elastic_public_ip1" {
  value = aws_eip.db1.public_ip
  description = "public ip for the first database"
}


output "elastic_public_ip2" {
  value = aws_eip.db2.public_ip
   description = "public ip for the second database"
}


