provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "terraform-server" {
  ami = "ami-0430580de6244e02e"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
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
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
}
