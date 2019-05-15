  provider "aws" {
    region = "eu-west-3"
  }

  resource "aws_subnet" "kubernetes" {
    vpc_id = "${aws_vpc.kubernetes.id}"
    availability_zone = "eu-west-3a"
  }

  resource "aws_instance" "kube" {
    count = 3
    ami = "ami-0eeeef929db40543c" # Ubuntu 16.04 Version to meet test req.
    instance_type = "t2.micro"
    
    subnet_id = "${aws_subnet.kubernetes.id}"
    associate_public_ip_address = true
    
    availability_zone = "eu-west-3a"
  } 

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
  
