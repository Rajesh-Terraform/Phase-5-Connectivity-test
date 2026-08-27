variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ap-south-1"
}

variable "project_name" {
  type        = string
  default     = "connectivity-test"
}

variable "environment" {
  type        = string
  default     = "prod"
}

variable "spoke_vpc_cidr" {
  type        = string
  default     = "10.1.0.0/16"
}

variable "spoke_private_subnet_cidrs" {
  type = list(string)

  default = [
    "10.1.10.0/24",
    "10.1.20.0/24"
  ]
}

variable "availability_zones" {
  type = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}

variable "hub_vpc_cidr" {
  type        = string
  description = "Hub VPC CIDR"
}

variable "transit_gateway_id" {
  type        = string
  description = "Existing Transit Gateway ID"
}

variable "hub_test_ip" {
  type        = string
  description = "Private IP of a reachable test target in the hub"
}

variable "hub_test_port" {
  type        = number
  description = "TCP port exposed by the hub test target"
  default     = 80
}

variable "github_actions_role_arn" {
  type        = string
  description = "Optional GitHub Actions IAM role ARN"
  default     = ""
}
