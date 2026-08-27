module "private_ec2" {
  source = "./modules/private-ec2"

  vpc_id    = var.spoke_vpc_id
  subnet_id = var.private_subnet_id
}