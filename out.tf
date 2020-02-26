output "ELB" {
  value = aws_elb.myelb.dns_name
}