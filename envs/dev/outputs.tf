output "spoke_vpc_id" {
  value = module.spoke.vpc_id
}

output "private_subnet_id" {
  value = module.spoke.private_subnet_id
}

output "test_instance_id" {
  value = module.test_ec2.instance_id
}

output "test_instance_private_ip" {
  value = module.test_ec2.private_ip
}

output "transit_gateway_id" {
  value = module.tgw.transit_gateway_id
}
