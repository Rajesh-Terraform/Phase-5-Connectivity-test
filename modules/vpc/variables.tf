variable "name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "az" {
  type = string
}

variable "create_internet_gateway" {
  type    = bool
  default = false
}
