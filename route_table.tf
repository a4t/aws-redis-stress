resource "aws_route_table" "zone1" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "redis-stress-${var.envname}"
  }
}

resource "aws_route_table_association" "web_zone1" {
  subnet_id = "${aws_subnet.zone1.id}"
  route_table_id = "${aws_route_table.zone1.id}"
}