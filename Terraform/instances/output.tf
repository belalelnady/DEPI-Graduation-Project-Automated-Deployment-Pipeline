output "bastion_instance_id" {
  value       = aws_instance.bastion.id
}

output "private_instance_1_id" {
  value       = aws_instance.private_instance_1.id
}

output "private_instance_2_id" {
  value       = aws_instance.private_instance_2.id
}
