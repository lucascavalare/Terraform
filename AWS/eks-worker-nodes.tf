# EKS Worker Nodes 

resource "aws_iam_role" "test-node" {
  name = "terraform-eks-test-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "test-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.test-node.name}"
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.test-node.name}"
}

resource "aws_iam_role_policy_attachment" "test-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.test-node.name}"
}

resource "aws_iam_instance_profile" "demo-node" {
  name = "terraform-eks-demo"
  role = "${aws_iam_role.demo-node.name}"
}

# EC2 Security Group to network traffic
resource "aws_security_group" "test-node" {
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
  # Ingressing traffic 
  ingress {
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
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.test-node.id}"
  source_security_group_id = "${aws_security_group.test-node.id}"
  type                     = "ingress"
}

# Security Group rule to ingress node traffic from control plane cluster 
resource "aws_security_group_rule" "test-node-ingress-cluster" {
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.test-node.id}"
  source_security_group_id = "${aws_security_group.test-cluster.id}"
  type                     = "ingress"
}

# Creating IMAGE_ID to launch_configuration 
data "aws_ami" "ubuntu" {
  most_recent = true
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }
  owners = ["099720109477"] # Canonical
}  

# Launch Configuration with desirable AMI Ubuntu 16.04 
resource "aws_launch_configuration" "test" {
  #ami                      = "ami-0a8e17334212f7052" # Ubuntu 16.04 LTS EBS-SSD
  instance_type            = "t2.micro"
  image_id                 = "${data.aws_ami.ubuntu.id}"
  name_prefix              = "terraform-eks-test"
  security_groups          = ["${aws_security_group.test-node.id}"]
  associate_public_ip_address = true
  
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
resource "aws_autoscaling_group" "test" {
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.test.id}"
  max_size             = 2
  min_size             = 1 
  name                 = "terraform-eks-test"
  vpc_zone_identifier  = ["${aws_subnet.test.id}"]
  
  tag {
    key                 = "Name"
    value               = "terraform-eks-test"
    propagate_at_launch = true
  }
}
