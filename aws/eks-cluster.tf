# EKS Cluster Resources

# Creating IAM Role to Cluster
resource "aws_iam_role" "test-cluster" {
  name = "terraform-eks-test-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "test-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.test-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "test-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.test-cluster.name}"
}

# Security Group to Cluster do communicate with Nodes  
resource "aws_security_group" "test-cluster" {
  name        = "terraform-eks-test-cluster"
  vpc_id      = "${aws_vpc.test.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-test"
  }
}

# Security Group to allow pods to communicate with the cluster API Server"
resource "aws_security_group_rule" "test-cluster-ingress-node-https" {
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.test-cluster.id}"
  source_security_group_id = "${aws_security_group.test-node.id}"
  type                     = "ingress"
}

# Security Group to allow workstation to communicate with the cluster API Server"
resource "aws_security_group_rule" "test-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.test-cluster.id}"
  to_port           = 443
  type              = "ingress"
}

resource "aws_eks_cluster" "test" {
  name     = "${var.cluster-name}"
  role_arn = "${aws_iam_role.test-cluster.arn}"
  
  vpc_config {
    security_group_ids = ["${aws_security_group.test-cluster.id}"]
    subnet_ids         = ["${aws_subnet.test.id}"]
  }
}
