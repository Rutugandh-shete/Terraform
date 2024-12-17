provider "aws" {
  region = "us-east-1"
  access_key = "AKIAUZPNLDWOLYSWCLZG"
  secret_key = "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"

}

resource "aws_instance" "instance" {
  ami                    = "ami-0866a3c8686eaeeba"
  instance_type          = "t2.micro"
  key_name               = "new_key"
  tags = {
    Name = "Terraform_instance"
  }
}

