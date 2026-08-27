output "instance_id" {
  value = aws_instance.this.id
}

output "private_ip" {
  value = aws_instance.this.private_ip
}

output "instance_profile" {
  value = aws_iam_instance_profile.ssm.name
}
