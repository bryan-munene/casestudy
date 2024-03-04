terraform {
  backend "s3" {
    bucket         = "emirates-casestudy-tf"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "emirates-casestudy-tf"
  }
}
