terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = "eu-west-2"
}
# Secondary provider for CloudFront certificates
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}