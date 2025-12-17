variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "docker_image" {
  description = "Docker image to deploy"
  type        = string
  # Assurez-vous que cette image est publique ou configurez l'authentification Docker
  default     = "shiroiryu753/heh-flask:latest" 
}
