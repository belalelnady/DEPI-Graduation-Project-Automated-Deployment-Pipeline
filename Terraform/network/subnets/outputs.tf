output "subnets_id" {
  description = "Mapping of subnet names to their IDs."
  value = { for key, subnet in aws_subnet.subnets : key => subnet.id }
}

output "private_subnets_ids_map" {
 
  value = { for key, subnet in aws_subnet.subnets : key => subnet.id  if !subnet.map_public_ip_on_launch}
}


output "puplic_subnets_id" {
  value = tolist([for _, subnet in aws_subnet.subnets : subnet.id if subnet.map_public_ip_on_launch])
}
output "private_subnets_id" {
   value = tolist([for _, subnet in aws_subnet.subnets : subnet.id if !subnet.map_public_ip_on_launch])
}