output "spoke_vpc_id" {
  description = "Spoke VPC ID"
  value       = module.spoke.vpc_id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = module.spoke.private_subnet_id
}

output "test_instance_id" {
  description = "Private test EC2 instance ID"
  value       = module.test_ec2.instance_id
}

output "test_instance_private_ip" {
  description = "Private IP of test EC2"
  value       = module.test_ec2.private_ip
}

output "transit_gateway_id" {
  description = "Transit Gateway ID"
  value       = module.tgw.transit_gateway_id
}
