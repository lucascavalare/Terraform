provider "aws" { 
  region = "eu-west-3"
}

resource "aws_db_instance" "mysqldb" { 
  engine = "mysql"
  allocated_storage = 10 
  instance_class = "db.t2.micro"
  name = "mysqldb_database"
  username = "admin"
  password = "${var.db_password}"
}
