output "spoke_vpc_id" {
  description = "Spoke VPC ID"
  value       = module.spoke.vpc_id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = module.spoke.private_subnet_id
}



output "transit_gateway_id" {
  description = "Transit Gateway ID"
  value       = module.tgw.transit_gateway_id
}


