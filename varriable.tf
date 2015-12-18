variable "aws_region" {
  default = "ap-northeast-1"
}

provider "aws" {
  region = "${var.aws_region}"
}

variable "envname" {}
variable "prefix_ip" {}
variable "availability_zone" {
  default = {
    "zone1" = "ap-northeast-1a"
  }
}

variable "key_pair" {
  default = ""
}
variable "ami_id" {
  default = {
    "web" = "ami-936d9d93"
  }
}
variable "instance_type" {
  default = {
    "web"   = "t2.micro"
    "redis" = "cache.m1.small"
  }
}
variable "instance_count" {
  default = "1"
}

variable "developers_ip" {
  default = ""
}