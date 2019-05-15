# Provider AWS 
  provider "aws" {
    # to US-EAST-1 Region
    region = "us-east-1"
  }
  # Instance with Kubernetes 
  resource "aws_instance" "test" {
    count = 2
    #ami = "ami-0a313d6098716f372" Ubuntu 18.04
    ami = "ami-0565af6e282977273" # Ubuntu 16.04 Required to test
    instance_type = "t2.micro"
    
    subnet_id = "${aws_subnet.kubernetes.id}"
    private_ip = "${cidrhost("10.43.0.0/16", 10 + count.index)}"
    associate_public_ip_address = true

    availability_zone = "eu-west-1a"
    vpc_security_group_ids = ["${aws_security_group.kubernetes.id}"]
    key_name = "my-keypair"
  }  

