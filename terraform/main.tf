terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Remplacez par le nom de votre bucket S3 existant
    bucket = "mon-bucket-terraform-state-unique" 
    key    = "projet-action/terraform.tfstate"
    region = "eu-west-3"
  }
}

provider "aws" {
  region = var.aws_region
}
