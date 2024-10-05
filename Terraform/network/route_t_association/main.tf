# ------ to add the subnets to the route tables 
resource "aws_route_table_association" "rt_association" {
  count = length(var.subnet_id_list)
  subnet_id      = var.subnet_id_list[count.index]
  route_table_id = var.rt_id
}

