# ---------------------------------------------------------
# ENDPOINT SECURITY GROUP
# ---------------------------------------------------------

resource "aws_security_group" "vpce" {
  name        = "ssm-vpc-endpoints-sg"
  description = "Allow HTTPS from EC2 to VPC endpoints"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    description = "Allow outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ---------------------------------------------------------
# SSM
# ---------------------------------------------------------

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [aws_security_group.vpce.id]
  private_dns_enabled = true
}

# ---------------------------------------------------------
# SSM MESSAGES
# ---------------------------------------------------------

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [aws_security_group.vpce.id]
  private_dns_enabled = true
}

# ---------------------------------------------------------
# EC2 MESSAGES
# ---------------------------------------------------------

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [aws_security_group.vpce.id]
  private_dns_enabled = true
}
