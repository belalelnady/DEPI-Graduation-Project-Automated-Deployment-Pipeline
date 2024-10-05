resource "aws_route_table" "routing_table" {
  vpc_id = var.vpc_id
  # connect to internet through the internet gw
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
  
  tags = {
    Name = var.routing_table_name
  }
}




