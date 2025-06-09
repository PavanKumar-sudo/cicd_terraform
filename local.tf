locals {
  ec2_instances = {
    "app1" = {
      name = var.app1_instance_name
    },
    "app2" = {
      name = var.app2_instance_name
    }
  }
  owners = var.business_divsion
  environment = var.environment
  name = "${var.business_divsion}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }


 # Dynamically choose AMI filter and owner based on OS
  ami_filters = {
    amazon = {
      owners = ["amazon"]
      name   = "amzn2-ami-hvm-*-gp2"
    }
    ubuntu = {
      owners = ["099720109477"]
      name   = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    }
  }

  user_data_file = var.os_type == "ubuntu" ? "${path.module}/ubuntu.sh" : "${path.module}/user_data.sh"

}