data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "random_id" "server_suffix" {
  byte_length = 4
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  security_groups = [aws_security_group.app_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              # Désactiver UFW pour éviter les blocages firewall locaux
              sudo ufw disable

              sudo apt-get update
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              
              # Lancer le conteneur avec redémarrage automatique
              sudo docker run -d --restart always -p 80:5000 ${var.docker_image}
              EOF

  tags = {
    Name = "Flask-App-Server-${random_id.server_suffix.hex}"
  }
}
