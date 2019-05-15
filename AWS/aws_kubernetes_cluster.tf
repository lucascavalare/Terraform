  provider "aws" {
    region = "eu-west-3"
  }
  
  resource "aws_vpc" "test" {
    cidr_block = "10.0.0.0/16"
    tags = "${
      map(
      "Name", "terraform-eks-test-node",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
      )
    }"
  }
  
  resource "aws_subnet" "kubernetes" {
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
    cidr_block        = "10.0.${count.index}.0/24"
    vpc_id            = "${aws_vpc.test.id}"

    tags = "${
      map(
      "Name", "terraform-eks-test-node",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
      )
    }"
  }

  resource "aws_internet_gateway" "test" {
    vpc_id = "${aws_vpc.test.id}"
    tags = {
      Name = "terraform-eks-test"
    }
  }

  resource "aws_route_table" "test" {
    vpc_id = "${aws_vpc.test.id}"

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.test.id}"
    }
  }

  resource "aws_instance" "kube" {
    count = 3
    ami = "ami-0eeeef929db40543c" # Ubuntu 16.04 Version to meet test req.
    instance_type = "t2.micro"
    
    #subnet_id = "${aws_subnet.kubernetes.id}"
    associate_public_ip_address = true
    
    availability_zone = "eu-west-3a"
  } 

/*
  resource "aws_elb" "kubernetes_api" {
    name = "kube-api"
    instances = ["${aws_instance.controller.*.id}"]
    subnets = ["${aws_subnet.kubernetes.id}"]
    cross_zone_load_balancing = false

    security_groups = ["${aws_security_group.kubernetes_api.id}"]

    listener {
      lb_port = 6443
      instance_port = 6443
      lb_protocol = "TCP"
      instance_protocol = "TCP"
    }

    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 15
      target = "HTTP:8080/healthz"
      interval = 30
    }
  }
*/  
