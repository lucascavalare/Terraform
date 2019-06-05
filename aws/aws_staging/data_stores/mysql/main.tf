# Setting Up Provider
provider "aws" { 
  region = "eu-west-3"
}

# Creating MySQL RDS Instance
resource "aws_db_instance" "mysqldb" { 
  engine = "mysql"
  allocated_storage = 10 
  instance_class = "db.t2.micro"
  name = "mysqldb_database"
  username = "admin"
  password = "${var.db_password}"
}

# Adding Remote State File Config
data "terraform_remote_state" "db" {
  backend = "s3"
  config {
    bucket = "(terraform_state)
    key = "aws_staging/data-stores/mysql/terraform.tfstate"
    region = "eu-west-3"
  }
}
