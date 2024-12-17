# Terraform with Jenkins Pipeline

This repository contains a Terraform configuration (`s3.tf`) to deploy AWS resources, along with instructions to set up a Jenkins pipeline for automating the deployment.

---

## **Prerequisites**

Before running the pipeline, ensure the following tools and configurations are in place:

1. **Jenkins Setup**:
   - Install Jenkins
     ````bash
     sudo apt update -y
sudo apt install fontconfig openjdk-17-jre -y

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
````
   - Jenkins is installed and running on your server.
   - Required plugins:
     - [Pipeline](https://plugins.jenkins.io/workflow-aggregator/)
     - [Git](https://plugins.jenkins.io/git/)
     - [AWS CLI](https://plugins.jenkins.io/aws-cli/)

3. **Terraform**:
   - Install Terraform on the Jenkins server:
     ```bash
     wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
     echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
     sudo apt update && sudo apt install terraform
     terraform --version
     ```

4. **AWS CLI**:
   - Install the AWS CLI:
     ```bash
     curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
     sudo apt install unzip 
     unzip awscliv2.zip
     sudo ./aws/install
     aws --version
     ```
   - Configure AWS credentials:
     ```bash
     aws configure
     ```

---

## **Pipeline Setup**

### **1. Configure Jenkins Pipeline**
Add the following pipeline script in Jenkins:

```groovy
pipeline {
    agent any
    environment {
        AWS_REGION = "us-east-1" // Specify your AWS region
    }
    stages {
        stage("Code Checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/Rutugandh-shete/Terraform.git'
            }
        }
        stage("Initialize and Apply Terraform") {
            steps {
                withAWS(region: 'us-east-1') {
                    sh 'terraform init'
                    sh 'terraform plan'
                    sh 'terraform apply --auto-approve'
                    sh 'terraform destroy --auto-approve'
                }
            }
        }
    }
}
