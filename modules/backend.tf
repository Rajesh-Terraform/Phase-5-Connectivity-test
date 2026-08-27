terraform {
  backend "s3" {
    bucket = "terraformstatefile9"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}