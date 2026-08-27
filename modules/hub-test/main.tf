data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_security_group" "hub_test" {
  name        = "${var.name}-hub-test-sg"
  description = "Hub TGW connectivity test"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from spoke"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.spoke_cidr]
  }

  egress {
    description = "Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ssm_parameter.amazon_linux.value
  instance_type = var.instance_type

  subnet_id = var.subnet_id

  associate_public_ip_address = false

  vpc_security_group_ids = [
    aws_security_group.hub_test.id
  ]

  user_data = <<-EOF
              #!/bin/bash

              dnf install -y nginx

              systemctl enable nginx
              systemctl start nginx

              echo "SUCCESS: Traffic reached the HUB server through Transit Gateway" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "${var.name}-hub-test"
  }
}