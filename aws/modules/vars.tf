# Cluster name variable.
variable "cluster_name" {
  description = "The name to use for all the cluster resources"
}

# DB remote state bucket.
variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
}

# DB remote state variable 
variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
}

# EC2 instance type.
variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
}

# Min size to cluster.
variable "min_size" {
description = "The minimum number of EC2 Instances in the ASG"
}

# Max size to cluster.
variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
}
