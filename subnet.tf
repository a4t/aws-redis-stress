resource "aws_subnet" "zone1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.prefix_ip}.10.0/24"
  availability_zone = "${var.availability_zone.zone1}"

  tags {
    Name = "redis-stress-${var.envname}"
  }
}
