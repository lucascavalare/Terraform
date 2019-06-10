# Inserting provider as modules.
provider "aws" { 
  region = "us-east-1"
}

# Adding modules as contents. 
module "webserver_cluster" {
  source = "../modules"
}
