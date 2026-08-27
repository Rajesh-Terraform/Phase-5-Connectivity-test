resource "aws_vpc_endpoint" "s3" {
  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"

  vpc_endpoint_type = "Gateway"

  route_table_ids = var.private_route_table_ids

  tags = {
    Name = "s3-gateway-endpoint"
  }
}

data "aws_region" "current" {}

locals {
  interface_services = [
    "ssm",
    "ssmmessages",
    "ec2messages",
    "logs",
    "monitoring"
  ]
}

resource "aws_vpc_endpoint" "interface" {
  for_each = toset(local.interface_services)

  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${data.aws_region.current.name}.${each.key}"

  vpc_endpoint_type = "Interface"

  subnet_ids = var.private_subnet_ids

  security_group_ids = [
    var.endpoint_security_group_id
  ]

  private_dns_enabled = true

  tags = {
    Name    = "${each.key}-interface-endpoint"
    Service = each.key
  }
}
