output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.this.id
}

output "transit_gateway_route_table_id" {
  value = aws_ec2_transit_gateway_route_table.this.id
}

output "attachment_ids" {
  value = {
    for name, attachment in aws_ec2_transit_gateway_vpc_attachment.this :
    name => attachment.id
  }
}
