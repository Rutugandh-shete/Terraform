provider "aws" {
  region = "us-east-1"


}

resource "aws_instance" "instance" {
  ami                    = "ami-0866a3c8686eaeeba"
  instance_type          = "t2.micro"
  key_name               = "new_key"
  tags = {
    Name = "Terraform_instance"
  }
}

