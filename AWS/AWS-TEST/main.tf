# Setting up Provider
provider "aws" { 
  region = "us-east-1"
}

# Creating the S3 Bucket to store Terraform State
resource "aws_s3_bucket" "terraform_state" { 
  bucket = "terraform-up-and-running-state-store"
 
  versioning { 
    enabled = true
  }
  
  lifecycle { 
    prevent_destroy = true
  }
}
