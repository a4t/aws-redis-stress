resource "aws_elasticache_parameter_group" "redis" {
  name = "redis-stress-${var.envname}"
  family = "redis2.8"
  description = "redis-stress-${var.envname}-parameter-group"
}

resource "aws_elasticache_subnet_group" "redis" {
  name = "redis-stress-${var.envname}"
  description = "redis-stress-${var.envname}-subnet-group"
  subnet_ids = [
    "${aws_subnet.zone1.id}"
  ]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id = "rd-stress-${var.envname}"
  engine = "redis"
  engine_version = "2.8.22"
  node_type = "${var.instance_type.redis}"
  subnet_group_name = "${aws_elasticache_subnet_group.redis.id}"
  security_group_ids = ["${aws_security_group.redis.id}"]
  port = 6379
  num_cache_nodes = "1"
  parameter_group_name = "${aws_elasticache_parameter_group.redis.id}"

  tags {
    Name = "redis-stress-${var.envname}"
  }
}