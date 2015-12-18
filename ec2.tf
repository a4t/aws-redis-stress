resource "aws_launch_configuration" "web" {
  name = "redis-stress-${var.envname}"
  image_id = "${var.ami_id.web}"
  instance_type = "${var.instance_type.web}"
  security_groups = ["${aws_security_group.web.id}"]
  key_name = "${var.key_pair}"
  associate_public_ip_address = true
  root_block_device = {
    volume_type = "gp2"
    volume_size = "20"
  }
}

resource "aws_autoscaling_group" "api_autoscaling_group" {
  availability_zones = ["${var.availability_zone.zone1}"]
  vpc_zone_identifier = ["${aws_subnet.zone1.id}"]
  name = "redis-stress-${var.envname}-web"
  max_size = "${var.instance_count.web}"
  min_size = "${var.instance_count.web}"
  default_cooldown = 300
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.web.name}"

  tag {
    key = "Name"
    value = "redis-stress-${var.envname}"
    propagate_at_launch = true
  }
}