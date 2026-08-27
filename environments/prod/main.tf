module "spoke" {
  source = "../../modules/spoke-vpc"

  name = var.project_name

  vpc_cidr = var.spoke_vpc_cidr

  availability_zones = var.availability_zones

  private_subnet_cidrs = var.spoke_private_subnet_cidrs
}

# ------------------------------------------------------------
# Security group for VPC interface endpoints
# ------------------------------------------------------------

resource "aws_security_group" "vpce" {
  name        = "${var.project_name}-vpce"
  description = "Allow HTTPS from private EC2 instances to VPC endpoints"
  vpc_id      = module.spoke.vpc_id

  ingress {
    description = "HTTPS from spoke VPC"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.spoke_vpc_cidr]
  }

  egress {
    description = "Endpoint return traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-vpce-sg"
  }
}

# ------------------------------------------------------------
# VPC endpoints
# ------------------------------------------------------------

module "endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id = module.spoke.vpc_id

  private_subnet_ids = module.spoke.private_subnet_ids

  private_route_table_ids = module.spoke.private_route_table_ids

  endpoint_security_group_id = aws_security_group.vpce.id
}

# ------------------------------------------------------------
# Security group for private test EC2
# ------------------------------------------------------------

resource "aws_security_group" "test_instance" {
  name        = "${var.project_name}-instance"
  description = "Private connectivity test instance"
  vpc_id      = module.spoke.vpc_id

  # HTTPS to AWS interface endpoints
  egress {
    description = "HTTPS to AWS VPC endpoints"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.spoke_vpc_cidr]
  }

  # Connectivity to the hub through TGW
  egress {
    description = "Connectivity to hub through TGW"
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
    cidr_blocks = [var.hub_vpc_cidr]
  }

  tags = {
    Name = "${var.project_name}-instance-sg"
  }
}

# ------------------------------------------------------------
# TGW attachment
# ------------------------------------------------------------

module "tgw" {
  source = "../../modules/tgw-attachment"

  vpc_id = module.spoke.vpc_id

  subnet_ids = module.spoke.private_subnet_ids

  private_route_table_ids = module.spoke.private_route_table_ids

  transit_gateway_id = var.transit_gateway_id

  hub_vpc_cidr = var.hub_vpc_cidr
}

# ------------------------------------------------------------
# Private EC2 managed by SSM
# ------------------------------------------------------------

module "test_instance" {
  source = "../../modules/ssm-test-instance"

  name = "${var.project_name}-ec2"

  subnet_id = module.spoke.private_subnet_ids[0]

  security_group_id = aws_security_group.test_instance.id

  instance_type = "t3.micro"
}
