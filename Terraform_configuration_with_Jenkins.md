# Terraform S3 Setup

This repository contains Terraform configuration files to set up and manage an S3 bucket in AWS.

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- **Terraform**: v1.5 or later  
  Install Terraform using the commands below:

  ```bash
  mkdir terraform
  cd terraform/
  wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update && sudo apt install terraform
  chmod +x /usr/local/bin/terraform
  terraform --version
