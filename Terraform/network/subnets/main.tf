resource "aws_subnet" "subnets" {  
  for_each = var.subnet_data
  vpc_id = var.vpc-id

  cidr_block = each.value.cidr
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_value

  tags = {
    Name =  each.key
  }
}
