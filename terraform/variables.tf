variable "aws" {
  type = map(string)
  description = "AWS provider particulars"
  default = {
    "region" = "us-east-1"
  }
}

variable "vpc" {
  type = map(string)
  description = "VPC details"
  default = {
    "name" = "casestudy"
    "cidr" = "10.0.0.0/16"
  }
}

variable "subnets" {
  type = map(list(string))
  description = "Subnet details"
  default = {
    "private_subnets" = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    "public_subnets" = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    "azs" = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
}

variable "eks" {
  type = map(string)
  description = "EKS details"
  default = {
    "name" = "casestudy"
    "version" = "1.29"
  }
}

variable "tags" {
  type = map(string)
  description = "Tags to add to resources"
  default = {
    "use" = "casestudy"
  }
}
