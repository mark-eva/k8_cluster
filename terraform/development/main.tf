#Define local variables

locals {
  cidr_block      = "10.0.0.0/24"
  security_groups = "module.poc_sec_group.sec_group_id"
  subnet_id       = "module.poc_subnet.subnet_id"
}

#create VPC

module "dev_vpc" {
  source     = "../modules/vpc"
  cidr_block = local.cidr_block
}


#Create Security Group
module "dev_sec_group" {
  source           = "../modules/sec_group"
  sec_group_name   = "dev_security_group"
  sec_group_vpc_id = module.dev_vpc.vpc_id
}

# Create subnet

module "dev_subnet" {
  source     = "../modules/subnet"
  cidr_block = local.cidr_block
  vpc_id     = module.dev_vpc.vpc_id
}




# Code that creates master and slave nodes

module "master" {
  source          = "../modules/vm"
  instance_type   = "t2.medium"
  ami_name        = "ami-192a9460"
  vpc_security_group_ids = [module.dev_sec_group.sec_group_id]
  subnet_id       = module.dev_subnet.subnet_id
}

module "node_1" {
  source          = "../modules/vm"
  instance_type   = "t2.medium"
  ami_name        = "ami-192a9460"
  vpc_security_group_ids = [module.dev_sec_group.sec_group_id]
  subnet_id       = module.dev_subnet.subnet_id
}

module "node_2" {
  source          = "../modules/vm"
  instance_type   = "t2.medium"
  ami_name        = "ami-192a9460"
  vpc_security_group_ids = [module.dev_sec_group.sec_group_id]
  subnet_id       = module.dev_subnet.subnet_id
}

# Deploy public key to the newly created vms

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("/mnt/c/Main/08_keys/public_key.pub")
}


# Add an elastic IP to the vms
resource "aws_eip" "master" {
  instance = module.master.vm_id
  vpc      = true
}

resource "aws_eip" "node_1" {
  instance = module.node_1.vm_id
  vpc      = true
}

resource "aws_eip" "node_2" {
  instance = module.node_2.vm_id
  vpc      = true
}



# Set up an internet gateway to route to your VPC
resource "aws_internet_gateway" "k8gateway" {
  vpc_id = module.dev_vpc.vpc_id
}


# Create a route table 

resource "aws_route_table" "dev_route_table" {
  vpc_id = module.dev_vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8gateway.id
  }
}

# Associate subnet to the route table  


resource "aws_route_table_association" "dev_subnet_to_routetable" {
  subnet_id      = module.dev_subnet.subnet_id
  route_table_id = aws_route_table.dev_route_table.id
}



# generate inventory file for Ansible
resource "local_file" "ansible_conf" {
  content = templatefile("../../ansible/templates/hosts.tpl",
    {
      master = aws_eip.master.public_ip
      worker_1 = aws_eip.node_1.public_ip
      worker_2 = aws_eip.node_2.public_ip
    }
  )
  filename = "../../ansible/development"
}


