resource "aws_launch_configuration" "my_launchconfig" {
  name_prefix     = "my_launchconfig"
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.sginstance.id]
  user_data       = templatefile("script.sh.tpl", {
    my_name = "Dmitriy"
  })
  lifecycle {
      create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "my_autoscaling" {
  name = "my_autoscaling"
  vpc_zone_identifier       = [aws_subnet.my_vpc_public1.id, aws_subnet.my_vpc_public2.id]
  launch_configuration      = aws_launch_configuration.my_launchconfig.name
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.myelb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}