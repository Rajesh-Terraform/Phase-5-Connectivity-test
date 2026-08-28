data "aws_availability_zones" "available" {
  state = "available"
}

module "hub" {
  source = "../../modules/vpc"

  name = "${var.project_name}-hub"

  vpc_cidr            = var.hub_vpc_cidr
  private_subnet_cidr = var.hub_subnet_cidr

  az = data.aws_availability_zones.available.names[0]

  create_internet_gateway = false
}

module "spoke" {
  source = "../../modules/vpc"

  name = "${var.project_name}-spoke"

  vpc_cidr            = var.vpc_cidr
  private_subnet_cidr = var.private_subnet_cidr

  az = data.aws_availability_zones.available.names[0]

  create_internet_gateway = false
}


module "tgw" {
  source = "../../modules/tgw"

  name = "${var.project_name}-tgw"

  vpc_attachments = {
    hub = {
      vpc_id = module.hub.vpc_id

      subnet_ids = [
        module.hub.private_subnet_id
      ]
    }

    spoke = {
      vpc_id = module.spoke.vpc_id

      subnet_ids = [
        module.spoke.private_subnet_id
      ]
    }
  }
}
