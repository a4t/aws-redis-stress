## Private Route 53
resource "aws_route53_zone" "private" {
  name = "redis.stress"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route53_record" "redis" {
  zone_id = "${aws_route53_zone.private.zone_id}"
  name = "master"
  type = "CNAME"
  ttl = "300"
  records = [
    "${aws_elasticache_cluster.redis.cache_nodes.0.address}"
  ]
}
