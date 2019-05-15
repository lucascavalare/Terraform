resource "aws_instance" "worker" {
    count = 3
    ...
    tags {
      Owner = "Lucas"
      Name = "worker-${count.index}"
      ansibleFilter = "Kubernetes01"
      ansibleNodeType = "worker"
      ansibleNodeName = "worker${count.index}"
    }
  }
}
