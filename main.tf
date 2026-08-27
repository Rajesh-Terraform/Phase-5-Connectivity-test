module "private_ec2" {
  source = "./modules/private-ec2"

  name          = "${var.name}-spoke"
  vpc_id        = var.spoke_vpc_id
  subnet_id     = var.spoke_private_subnet_id
  instance_type = var.instance_type
}