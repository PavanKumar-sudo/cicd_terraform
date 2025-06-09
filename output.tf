output "aws_instance_id" {
  description = "The ID of the created EC2 instance"
 value       = { for k, inst in aws_instance.ec2q1 : k => inst.id }
}
output "aws_instance_name" {
  description = "The name of the created EC2 instance"
  value       = { for k, inst in aws_instance.ec2q1 : k => inst.tags["Name"] }
}
output "aws_instance_public_ip" {
  description = "The public IP address of the created EC2 instance"
  value       = { for k, inst in aws_instance.ec2q1 : k => inst.public_ip }
}
output "security_group_id" {
  description = "The ID of the security group created for the EC2 instance"
  value       = aws_security_group.ec2_sg1.id
}
output "security_group_name" {
  description = "The name of the security group created for the EC2 instance"
  value       = aws_security_group.ec2_sg1.name
}