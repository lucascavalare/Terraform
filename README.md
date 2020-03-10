# Terraform
  [Terraform](https://www.terraform.io/)
    - Deploying with Infrastructure-as-a-code (IAC) to Public Cloud Providers like Amazon Web Services and Azure.
  
# Ansible 
  [Ansible](https://www.ansible.com/)
    - Infrastructure Deployments and Management with Ansible. 
    
   
   ## AWS
      - Deploying a Complete Amazon Web Services (AWS) Infrastructure, including (VPC, Subnet, SG, AZ, EC2, ELB, S3) with             Terraform and Managing those Deployments with Ansible.
      
      # Terragrunt
        [Terragrunt](https://www.gruntwork.io/)
          - Locking state files.
            To remove the need of run `terraform remote config` command for every Terraform project. Therefore, race                       conditions are still possible of two developers are using Terraform at the same time on the same state files.
          - Terragrunt is a thin wrapper for Terraform that manages remote state for you automatically and provides locking by             using [Amazon DynamoDB](https://aws.amazon.com/dynamodb/)
  
   ## AZURE
      - Deploying a Complete Infrastructure in Azure with Terraform and Do use Ansible to Manage Deployment Configurations             with Kubernetes Including One Master and Two Nodes. 
