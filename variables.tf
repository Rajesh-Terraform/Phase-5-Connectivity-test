variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "spoke_vpc_id" {
  description = "Spoke VPC ID"
  type        = string
}

variable "spoke_private_subnet_id" {
  description = "Private subnet ID in spoke VPC"
  type        = string
}

variable "spoke_cidr" {
  description = "Spoke VPC CIDR"
  type        = string
}

variable "hub_cidr" {
  description = "Hub VPC CIDR"
  type        = string
}

variable "hub_test_ip" {
  description = "Private IP of the hub test server"
  type        = string
}

variable "hub_test_security_group_id" {
  description = "Security group attached to hub test server"
  type        = string
}

variable "create_hub_test" {
  description = "Create a hub test EC2"
  type        = bool
  default     = false
}

variable "hub_subnet_id" {
  description = "Private subnet ID in hub"
  type        = string
  default     = ""
}

variable "hub_vpc_id" {
  description = "Hub VPC ID"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Private EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "name" {
  description = "Name prefix"
  type        = string
  default     = "phase5"
}