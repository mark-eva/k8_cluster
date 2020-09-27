
provider "aws" {
}

resource "aws_instance" "vm" {
  instance_type =  var.instance_type
  ami = var.ami_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id = var.subnet_id
  key_name = "deployer-key"

  root_block_device {
  delete_on_termination = true  

  }

}



