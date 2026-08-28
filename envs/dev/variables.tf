variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "phase5-connectivity"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "Spoke VPC CIDR"
  type        = string
  default     = "10.20.0.0/16"
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
  default     = "10.20.1.0/24"
}

variable "hub_vpc_cidr" {
  description = "Hub VPC CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "hub_subnet_cidr" {
  description = "Hub subnet CIDR"
  type        = string
  default     = "10.10.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
