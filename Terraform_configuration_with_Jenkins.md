# **Terraform with Jenkins Pipeline**

This repository contains Terraform files and a Jenkins pipeline to automate infrastructure provisioning and management using Terraform.

---

## **Steps to Install Jenkins and Configure Pipeline**

### **Install Jenkins on Ubuntu**
Follow the steps below to install Jenkins and its prerequisites:

1. **Update the System**:
    ```bash
    sudo apt update -y
    ```
2. **Install OpenJDK 17**:
    ```bash
    sudo apt install fontconfig openjdk-17-jre -y
    ```
3. **Add Jenkins Repository Key**:
    ```bash
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    ```
4. **Add Jenkins Repository**:
    ```bash
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    ```
5. **Update Repositories and Install Jenkins**:
    ```bash
    sudo apt-get update -y
    sudo apt-get install jenkins -y
    ```
6. **Start and Enable Jenkins**:
    ```bash
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    ```

### **Install Terraform**
1. **Create a Terraform Directory**:
    ```bash
    mkdir terraform
    cd terraform/
    ```
2. **Add HashiCorp GPG Key**:
    ```bash
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    ```
3. **Add Terraform Repository**:
    ```bash
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    ```
4. **Install Terraform**:
    ```bash
    sudo apt update && sudo apt install terraform
    chmod +x /usr/local/bin/terraform
    terraform --version
    ```

### **Install AWS CLI**
1. **Download AWS CLI**:
    ```bash
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    ```
2. **Install AWS CLI**:
    ```bash
    sudo apt install unzip
    unzip awscliv2.zip
    sudo ./aws/install
    aws --version
    ```

---

## **Jenkins Pipeline Code**
Add the following Jenkins pipeline script in your `Jenkinsfile` to automate Terraform tasks.
![image](https://github.com/user-attachments/assets/ec9bb142-f5f9-42a9-b14c-b4595531b794)


```groovy
pipeline {
    agent any
    environment {
        AWS_REGION = "us-east-1"
    }
    stages {
        stage("Code Checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/Rutugandh-shete/Terraform.git'
            }
        }
        stage("Initialize and Deploy") {
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

