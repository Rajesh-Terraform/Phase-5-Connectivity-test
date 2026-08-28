resource "aws_vpc_endpoint" "s3" {
  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.region}.s3"

  vpc_endpoint_type = "Gateway"

  route_table_ids = var.route_table_ids

  tags = {
    Name = "s3-endpoint"
  }
}

resource "aws_security_group" "endpoints" {
  name        = "vpce-endpoints"
  description = "Allow HTTPS to VPC endpoints"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.20.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.region}.monitoring"

  vpc_endpoint_type = "Interface"

  subnet_ids = [
    # Filled by caller through subnet_ids in a more complete implementation
  ]

  security_group_ids = [
    aws_security_group.endpoints.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "cloudwatch-endpoint"
  }
}
