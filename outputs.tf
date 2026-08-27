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

