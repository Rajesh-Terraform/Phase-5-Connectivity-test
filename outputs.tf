output "private_instance_id" {
  description = "Private spoke EC2 instance ID"
  value       = module.private_ec2.instance_id
}

output "private_instance_ip" {
  description = "Private spoke EC2 IP"
  value       = module.private_ec2.private_ip
}

output "private_instance_security_group" {
  description = "Private EC2 security group"
  value       = module.private_ec2.security_group_id
}

output "hub_test_instance_id" {
  description = "Hub test instance ID"
  value       = var.create_hub_test ? module.hub_test[0].instance_id : null
}

output "hub_test_private_ip" {
  description = "Hub test private IP"
  value       = var.create_hub_test ? module.hub_test[0].private_ip : null
}