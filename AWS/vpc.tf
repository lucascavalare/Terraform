  resource "aws_vpc" "kubernetes" {
    cidr_block = "10.43.0.0/16"
    enable_dns_hostnames = true
  }

  resource "aws_subnet" "kubernetes" {
    vpc_id = "${aws_vpc.kubernetes.id}"
    cidr_block = "10.43.0.0/16"
    availability_zone = "eu-west-1a"
  }
