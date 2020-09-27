variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
}

variable "ami_name" {
  description = "ami name of what you are referring to "
  type        = string

}


variable "vpc_security_group_ids" {
  description = "security group to be assigned to"
}

variable "subnet_id" {
  description = "subnet to be assigned to"
  
}

