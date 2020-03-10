
# - The include block tells Terragrunt to use the exact same Terragrunt configuration from the terraform.tfvars file specified via the path 
#   parameter. It behaves exactly as if you had copy/pasted the Terraform configuration from the included file's 
#   terragrunt = { ... } find_in_parent_folders(): This function returns the path to the first terraform.tfvars file it finds in the parent folders 
#   above the current terraform.tfvars file.

terragrunt = {
  include = "${find_in_parent_folders()}"
}
