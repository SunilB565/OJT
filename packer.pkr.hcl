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
  region        = "us-west-2"
  source_ami    = "ami-01cfd552ecdd27958"
  ssh_username  = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.example"]
  provisioner "shell" {
    inline = ["sudo apt-get update", "sudo apt-get install -y apache2"]
  }
  // Additional build configurations if needed
}
