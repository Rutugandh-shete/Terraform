provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
  

}

resource "aws_s3_bucket" "my_buck" {
  bucket = "backend-s3-buck"
  tags = {
    Name:"tf-buck"

  }
  
  
}
