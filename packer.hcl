builders {
  type             = "amazon-ebs"
  access_key       = "AKIAXYVS6QBHVGJ5VULI"
  secret_key       = "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"
  region           = "ap-south-1"
  source_ami       = "ami-02950dbba2cc7b721"
  instance_type    = "t2.micro"
  vpc_id           = "vpc-084dde02b8740acef"
  subnet_id        = "subnet-08c8fc60e7851959a"
  security_group_ids = ["sg-0783574eebd9067b7"]
  ssh_username     = "ubuntu"
  ami_name         = "ojt-${timestamp}"
  
  tags = {
    Name = "OJT-base-Ami"
  }
}

provisioners {
  type    = "shell"
  script  = "installscript.sh"
}