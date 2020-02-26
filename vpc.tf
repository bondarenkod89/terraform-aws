resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "My VPC"
  }
}

resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
      Name = "My GW"
  }
}

resource "aws_subnet" "my_vpc_public1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-central-1a"
  tags = {
    Name = "public 1"
  }
}

resource "aws_subnet" "my_vpc_public2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-central-1b"
  tags = {
    Name = "public 2"
  }
}

resource "aws_route_table" "my_route_public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gw.id
  }
  tags = {
    Name = "public route"
  }
}

resource "aws_route_table_association" "my-public-1-a" {
  subnet_id      = aws_subnet.my_vpc_public1.id
  route_table_id = aws_route_table.my_route_public.id
}

resource "aws_route_table_association" "my-public-2-a" {
  subnet_id      = aws_subnet.my_vpc_public2.id
  route_table_id = aws_route_table.my_route_public.id
}