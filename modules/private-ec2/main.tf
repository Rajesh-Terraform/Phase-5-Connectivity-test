data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_iam_role" "ssm" {
  name = "${var.name}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm" {
  name = "${var.name}-instance-profile"
  role = aws_iam_role.ssm.name
}

resource "aws_security_group" "private_ec2" {
  name        = "${var.name}-private-ec2-sg"
  description = "Private EC2 connectivity test security group"
  vpc_id      = var.vpc_id

  egress {
    description = "Allow outbound traffic for endpoint and TGW testing"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-private-ec2-sg"
  }
}

resource "aws_instance" "this" {
  ami = data.aws_ssm_parameter.amazon_linux.value

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  associate_public_ip_address = false

  iam_instance_profile = aws_iam_instance_profile.ssm.name

  vpc_security_group_ids = [
    aws_security_group.private_ec2.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              dnf install -y curl
              dnf install -y nc
              dnf install -y jq

              echo "Phase 5 private EC2 initialized" > /tmp/phase5.txt
              EOF

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "${var.name}-private-test"
  }
}

module "private_ec2" {
  source = "./modules/private-ec2"

  name          = "${var.name}-spoke"
  vpc_id        = var.spoke_vpc_id
  subnet_id     = var.spoke_private_subnet_id
  instance_type = var.instance_type
}