# Inserting provider as modules.
provider "aws" { 
  region = "eu-west-3"
}

# Adding modules as contents. 
module "webserver_cluster" {
  source = "../modules"
}
