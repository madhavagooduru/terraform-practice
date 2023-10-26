provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "terraform-server" {
  ami = "ami-0430580de6244e02e"
  instance_type = "t2.micro"
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.xhtml
              nohup busybox httpd -f -p 8080 &
              EOF
  user_data_replace_on_change = true
  tags = {
    Name = "terraform-server1"
  }
}

