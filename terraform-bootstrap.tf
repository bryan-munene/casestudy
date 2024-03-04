terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


## terraform backend requirements
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "emirates-casestudy-tf"
  tags = {
    "use" = "casestudy"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "emirates-casestudy-tf"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
