resource "aws_elb" "myelb" {
  name            = "myelb"
  subnets          = [aws_subnet.my_vpc_public1.id, aws_subnet.my_vpc_public2.id]
  security_groups = [aws_security_group.sg_elb.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my elb"
  }
}