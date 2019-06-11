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
