# Inserting provider as modules.
provider "aws" { 
  region = "eu-west-3"
}

# Input vars to web server as module contents.
module "webserver_cluster" {
source = "../modules"
      cluster_name = "webservers-stageing"
      db_remote_state_bucket = "(terraform_state)"
      db_remote_state_key = "aws_staging/data-stores/mysql/terraform.tfstate"
}
