output "spoke_vpc_id" {
  description = "Spoke VPC ID"
  value       = module.spoke.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.spoke.private_subnet_ids
}

output "test_instance_id" {
  description = "Private SSM test instance ID"
  value       = module.test_instance.instance_id
}

output "test_instance_private_ip" {
  description = "Private IP address of the test instance"
  value       = module.test_instance.private_ip
}

output "tgw_attachment_id" {
  description = "Spoke Transit Gateway attachment ID"
  value       = module.tgw.attachment_id
}

output "s3_endpoint_id" {
  description = "S3 Gateway VPC endpoint ID"
  value       = module.endpoints.s3_endpoint_id
}

output "interface_endpoints" {
  description = "AWS interface VPC endpoint IDs"
  value       = module.endpoints.interface_endpoint_ids
}
