resource "aws_security_group" "sginstance" {
  vpc_id = aws_vpc.my_vpc.id
  name = "sginstance"

  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_elb.id]
  }

  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "sginstance"
  }
}

resource "aws_security_group" "sg_elb" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = "elb"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg elb"
  }
}