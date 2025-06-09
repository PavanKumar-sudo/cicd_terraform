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
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-secuirtygroup-ec2-instance"
    }
  )
}

# Dynamically select the AMI
data "aws_ami" "selected" {
  most_recent = true
  owners      = local.ami_filters[var.os_type].owners

  filter {
    name   = "name"
    values = [local.ami_filters[var.os_type].name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# Load user data script dynamically
data "template_file" "userdata" {
  template = file(local.user_data_file)
}

# EC2 resource with dynamic user_data and ami
resource "aws_instance" "ec2q1" {
  for_each = local.ec2_instances

  ami                         = data.aws_ami.selected.id
  instance_type               = var.instance_type
  key_name                    = var.keypair_name
  associate_public_ip_address = true
  subnet_id                   = data.aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg1.id]
  user_data                   = data.template_file.userdata.rendered

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-${each.value.name}"
    }
  )
}