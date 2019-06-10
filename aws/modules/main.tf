*/
Profile definition was removed due to the modules insertion and was migrated to 
environment definition aws_staging/main.tf
/*

# Creating the S3 Bucket to store Terraform State.
resource "aws_s3_bucket" "terraform_state" { 
  bucket = "terraform-up-and-running-state-store"
 
  versioning { 
    enabled = true
  }
  
  lifecycle { 
    prevent_destroy = true
  }
}

# Print out ARN of your Bucket S3.
output "s3_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state.arn}"
} 

# Template file data source to get MySQL info.
data "template_file" "user_data" {
  template = "${file("user-data.sh")}"
  vars {
    server_port = "${var.server_port}"
    db_address = "${data.terraform_remote_state.db.address}"
    db_port = "${data.terraform_remote_state.db.port}"
  }
}
