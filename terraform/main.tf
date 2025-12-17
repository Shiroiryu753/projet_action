terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Remplacez par le nom de votre bucket S3 existant
    bucket = "terraform-state-projet-action-shiroiryu753" 
    key    = "projet-action/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}
