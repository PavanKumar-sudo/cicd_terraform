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
} 