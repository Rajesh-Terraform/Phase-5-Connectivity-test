output "spoke_vpc_id" {
  value = module.spoke.vpc_id
}

output "private_subnet_ids" {
  value = module.spoke.private_subnet_ids
}

output "test_instance_id" {
  value = module.test_instance.instance_id
}

output "test_instance_private_ip" {
  value = module.test_instance.private_ip
}

output "tgw_attachment_id" {
  value = module.tgw.attachment_id
}

output "s3_endpoint_id" {
  value = module.endpoints.s3_endpoint_id
}

output "interface_endpoints" {
  value = module.endpoints.interface_endpoint_ids
}

output "test_instance_id" {
  value = module.test_instance.instance_id
}

output "test_instance_private_ip" {
  value = module.test_instance.private_ip
}

