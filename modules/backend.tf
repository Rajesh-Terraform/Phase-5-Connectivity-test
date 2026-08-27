terraform {
  backend "s3" {
    bucket = "terraformstatefile9"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}