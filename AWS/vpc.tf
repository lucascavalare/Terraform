# VPC Resources

# Creating VPC 
resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
}

# Creating Subnet
resource "aws_subnet" "test" {
  availability_zone = "eu-west-3a"
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id = "${aws_vpc.test.id}"
}

# Creating Internet Gateway 
resource "aws_internet_gateway" "test" {
  vpc_id = "${aws_vpc.test.id}"
  
  tags = {
    Name = "terraform-eks-test"
  }
}

# Creating Routing Table
resource "aws_route_table" "test" {
  vpc_id = "${aws_vpc.test.id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test.id}"
  }
}

# Creating Route Table Association
resource "aws_route_table_association" "test" {
  subnet_id      = "${aws_subnet.test.id}"  
  route_table_id = "${aws_route_table_association.test.id}"
}
