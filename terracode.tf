# provider.tf
provider "aws" {
  region = "us-east-1"  # Update with your desired AWS region
}

# main.tf
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group for web traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Update with your desired source IP range
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Update with your desired source IP range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_instance" {
  ami           = "ami-0715c1897453cabd1"  # Update with your desired AMI ID
  instance_type = "t2.micro"      # Update with your desired instance type

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "web-instance"
  }
}
