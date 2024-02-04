provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "ap-south-1"  # Update with your desired AWS region
}

variable "aws_access_key" {
  type    = string
  default = "AKIAXYVS6QBHVGJ5VULI"
}

variable "aws_secret_key" {
  type    = string
  default = "ZD03jbbQR9JMk41G8qCBiOgUrIKO0GEUvkzBA9q3"
}

source "amazon-ebs" "example" {
  ami_name      = "example-ami"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  ssh_username  = "ubuntu"
  subnet_id     = "subnet-0917ac5111271f16a"
  vpc_id        = "vpc-03ebdc2c9f18fbfc9"
  source_ami    = "ami-01cfd552ecdd27958"
}

build {
  sources = ["source.amazon-ebs.example"]
  provisioner "shell" {
    inline = ["sudo apt-get update", "sudo apt-get install -y apache2"]
  }
}
