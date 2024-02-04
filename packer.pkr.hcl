variable "aws_access_key" {
  type    = string
  default = "your_aws_access_key"
}

variable "aws_secret_key" {
  type    = string
  default = "your_aws_secret_key"
}

source "amazon-ebs" "example" {
  ami_name      = "example-ami"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "ami-01cfd552ecdd27958"
}

build {
  sources = ["source.amazon-ebs.example"]
  provisioner "shell" {
    inline = ["sudo apt-get update", "sudo apt-get install -y apache2"]
  }
  // Additional build configurations if needed
}
