data "aws_availability_zones" "available" {
  state = "available"
}

# ---------------------------------------------------------
# HUB VPC
# ---------------------------------------------------------

module "hub" {
  source = "../../modules/vpc"

  name = "${var.project_name}-hub"

  vpc_cidr            = var.hub_vpc_cidr
  private_subnet_cidr = var.hub_subnet_cidr

  az = data.aws_availability_zones.available.names[0]

  create_internet_gateway = false
}

# ---------------------------------------------------------
# SPOKE VPC
# ---------------------------------------------------------

module "spoke" {
  source = "../../modules/vpc"

  name = "${var.project_name}-spoke"

  vpc_cidr            = var.vpc_cidr
  private_subnet_cidr = var.private_subnet_cidr

  az = data.aws_availability_zones.available.names[0]

  create_internet_gateway = false
}

# ---------------------------------------------------------
# TRANSIT GATEWAY
# ---------------------------------------------------------

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

# ---------------------------------------------------------
# SPOKE -> HUB ROUTE
# ---------------------------------------------------------

resource "aws_route" "spoke_to_hub" {
  route_table_id = module.spoke.private_route_table_id

  destination_cidr_block = var.hub_vpc_cidr

  transit_gateway_id = module.tgw.transit_gateway_id

  depends_on = [
    module.tgw
  ]
}

# ---------------------------------------------------------
# HUB -> SPOKE ROUTE
# ---------------------------------------------------------

resource "aws_route" "hub_to_spoke" {
  route_table_id = module.hub.private_route_table_id

  destination_cidr_block = var.vpc_cidr

  transit_gateway_id = module.tgw.transit_gateway_id

  depends_on = [
    module.tgw
  ]
}

# ---------------------------------------------------------
# VPC ENDPOINTS
# ---------------------------------------------------------


# ---------------------------------------------------------
# TEST EC2
# ---------------------------------------------------------

module "test_ec2" {
  source = "../../modules/ec2"

  # These arguments must match ../../modules/ec2/variables.tf
  # Example:
  name      = "${var.project_name}-test"
  vpc_id    = module.spoke.vpc_id
  subnet_id = module.spoke.private_subnet_id
}
