data "aws_vpc" "selected" {
  default = true
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_subnet" "public_subnet" {
  id = data.aws_subnets.all.ids[0]
}


resource "aws_security_group" "ec2_sg1"{
  name ="allow_ssh"
  description = "Allow SSH and Http traffic"
  vpc_id = data.aws_vpc.selected.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_instance" "ec2q1" {
  ami           = var.ami_id 
  instance_type = var.instance_type
  key_name      = var.keypair_name
  associate_public_ip_address = true
  subnet_id = data.aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg1.id]
  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "ExampleInstance"
  }
}