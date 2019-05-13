  provider "aws" {
    region = "us-east-1"
  }

  resource "aws_instance" "webserver" {
    ami = "ami-0eeeef929db40543c"
    instance_type = "t2.micro"
    
    tags {
      name = "Terraform"
    }
  }

  
