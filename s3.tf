provider "aws" {
  region = "us-east-1"
  access_key = "AKIA6IY357WR4L35FK5C"
  secret_key = "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"
  

}

resource "aws_s3_bucket" "my_buck" {
  bucket = "backend-s3-buck"
  tags = {
    Name:"tf-buck"

  }
  
  
}
