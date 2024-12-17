provider "aws" {
  region = "us-east-1"
  access_key = "AKIAUZPNLDWOLYSWCLZG"
  secret_key = "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"

}

resource "aws_s3_bucket" "my_buck" {
  bucket = "backend-s3-buck"
  tags = {
    Name:"tf-buck"

  }
  
}
