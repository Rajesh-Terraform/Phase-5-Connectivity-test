resource "aws_instance" "this" {
  ami = data.aws_ssm_parameter.al2023.value

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  associate_public_ip_address = false

  iam_instance_profile = aws_iam_instance_profile.ssm.name

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = var.name
  }
}
