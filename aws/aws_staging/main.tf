# Inserting provider as modules.
provider "aws" { 
  region = "eu-west-3"
}

# Adding modules as contents. 
module "webserver_cluster" {
  source = "../modules"
}

# Input vars to web server.
module "webserver_cluster" {
source = "../modules"
      cluster_name = "webservers-stageing"
      db_remote_state_bucket = "(terraform_state)"
      db_remote_state_key = "aws_staging/data-stores/mysql/terraform.tfstate"
}
