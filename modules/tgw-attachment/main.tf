resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  vpc_id = var.vpc_id

  subnet_ids = var.subnet_ids

  transit_gateway_id = var.transit_gateway_id

  dns_support = "enable"

  ipv6_support = "disable"

  transit_gateway_default_route_table_association = true

  transit_gateway_default_route_table_propagation = true

  tags = {
    Name = "spoke-tgw-attachment"
  }
}

resource "aws_route" "to_hub" {
  count = length(var.private_route_table_ids)

  route_table_id = var.private_route_table_ids[count.index]

  destination_cidr_block = var.hub_vpc_cidr

  transit_gateway_id = var.transit_gateway_id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.this
  ]
}
