variable "name" {
  description = "EC2 instance name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where EC2 will be deployed"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}  
  