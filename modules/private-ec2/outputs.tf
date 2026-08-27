output "instance_id" {
  value = aws_instance.this.id
}

output "private_ip" {
  value = aws_instance.this.private_ip
}

output "security_group_id" {
  value = aws_security_group.private_ec2.id
}