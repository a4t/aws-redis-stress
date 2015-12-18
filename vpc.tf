resource "aws_vpc" "vpc" {
  cidr_block = "${var.prefix_ip}.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags {
    Name = "redis-stress-${var.envname}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "redis-stress-${var.envname}"
  }
}