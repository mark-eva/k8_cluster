resource "aws_subnet" "poc_subnet" {
  cidr_block = var.cidr_block
  vpc_id = var.vpc_id
  
}