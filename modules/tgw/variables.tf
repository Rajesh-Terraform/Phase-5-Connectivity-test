variable "name" {
  type = string
}

variable "vpc_attachments" {
  description = "VPC attachments for the TGW"

  type = map(object({
    vpc_id     = string
    subnet_ids = list(string)
  }))
}
