# EKS Worker Nodes 

# EC2 Security Group to network traffic
resource "aws_security_group" "test" {
  name = "terraform-eks-test"
  description = "Security Group for Nodes"
  vpc_id = "${aws_vpc.test.id}"
  
  # Egressing traffic 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group rule to ingress all traffic node to node
resource "aws_security_group_rule" "test-node-ingress" {
  description              = "Allow nodes to communicate"
  from_port                = 0
  to_port                  = 65535
  procotol                 = "-1"
  security_group_id        = "${aws_security_group.test.id}"
  source_security_group_id = "${aws_security_group.test.id}"
  type                     = "ingress"
}

# Security Group rule to ingress node traffic from control plane cluster 
resource "aws_security_group_rule" "test-node-ingress-cluster" {
  description              = "Allow worker node to receive communication from control plane cluster"
  from_port                = 1025
  to_port                  = 65535
  procotol                 = "tcp"
  security_group_id        = "${aws_security_group.test.id}"
  source_security_group_id = "${aws_security_group.test.id}"
  type                     = "ingress"
}

# Launch Configuration with desirable AMI Ubuntu 16.04 
resource "aws_launch_configuration" "test" {
  ami                      = "ami-0a8e17334212f7052" # Ubuntu 16.04 LTS EBS-SSD
  instance_type            = "t2.micro"
  name_prefix              = "terraform-eks-test"
  security_groups          = ["${aws_security_group.test.id}"]
  associate_public_address = true
  
  # Run a remote provisioner on the instance after create it.
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start",
    ]
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group to scale desired load capacity
resource "aws_autoscaling_group" "test"
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.test.id}"
  max_size             = 2
  min_size             = 1 
  name                 = "terraform-eks-test"
  vpc_zone_identifier  = ${aws_subnet.test.*.id}"
  
  tag {
    key                 = "Name"
    value               = "terraform-eks-test"
    propagate_at_launch = true
  }
}
