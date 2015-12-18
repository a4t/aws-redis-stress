resource "aws_security_group" "web" {
  name = "web"
  vpc_id = "${aws_vpc.vpc.id}"
  description = "web"
}

resource "aws_security_group_rule" "web_allow_all_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.web.id}"
}

resource "aws_security_group_rule" "ssh_ingress" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${formatlist("%s", split(", ", var.developers_ip))}"]

  security_group_id = "${aws_security_group.web.id}"
}

resource "aws_security_group" "redis" {
  name = "redis"
  vpc_id = "${aws_vpc.vpc.id}"
  description = "redis"
}

resource "aws_security_group_rule" "redis_allow_all_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.redis.id}"
}

resource "aws_security_group_rule" "web_to_redis" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.web.id}"

  security_group_id = "${aws_security_group.redis.id}"
}
