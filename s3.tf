provider "aws" {
  region = "us-east-1"

}

resource "aws_s3_bucket" "my_buck" {
  bucket = "backend-s3-buck"
  tags = {
    Name:"tf-buck"

  }
  
}