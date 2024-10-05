module "vpc" {
  source   = "./network/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "load-balancer-vpc"
}

module "subnets" {
  source      = "./network/subnets"
  vpc-id      = module.vpc.vpc-id
  subnet_data = var.subnet_data
}

module "internet_gw" {
  source = "./network/internet_GW"
  vpc_id = module.vpc.vpc-id
  name   = "internet-gateway"
}

module "nat" {
  source    = "./network/NAT_GW"
  subnet_id = module.subnets.subnets_id["public-subnet1"]
  nat_name  = "lb-nat"
}

# public routing table
module "public_routing_table" {
  source             = "./network/route_table"
  vpc_id             = module.vpc.vpc-id
  gateway_id         = module.internet_gw.internet_gateway_id
  routing_table_name = "public-routing-table"
}

# public assossiiation
module "rt_public_assosiation" {
  source         = "./network/route_t_association"
  subnet_id_list = module.subnets.puplic_subnets_id
  rt_id          = module.public_routing_table.route_id
}


#private routing table
module "private_routing_tables" {
  source             = "./network/route_table"
  vpc_id             = module.vpc.vpc-id
  gateway_id         = module.nat.nat_gateway_id
  routing_table_name = "private-routing-table"
}

# private assossiiation
module "rt_private_assosiation" {
  source         = "./network/route_t_association"
  subnet_id_list = module.subnets.private_subnets_id
  rt_id          = module.private_routing_tables.route_id
}

#-------------security group--------
module "security_groups" {
  source = "./network/security_group"
  vpc_id = module.vpc.vpc-id
}


#------key-pair----
module "key_pair" {
  source   = "./key-pair"
  key_name = "pipeline"
}

# -------instances---
module "instances" {
  source                    = "./instances"
  ami_id                    = "ami-0a0e5d9c7acc336f1" 
  instance_type             = "t2.micro"
  public_subnet_id          = module.subnets.puplic_subnets_id[0]
  private_subnet_1_id       = module.subnets.private_subnets_id[0]
  private_subnet_2_id       = module.subnets.private_subnets_id[1]
  bastion_sg_id             = module.security_groups.bastion_sg_id
  private_sg_id             = module.security_groups.private_sg_id
  key_name                  = module.key_pair.key_name
  depends_on = [ module.key_pair , module.internet_gw , module.nat]
}
# -------------------LB--------------
module "load_balancer" {
  source                = "./load_balancer"
  vpc_id                = module.vpc.vpc-id
  public_subnets        = module.subnets.puplic_subnets_id
  alb_sg_id             = module.security_groups.alb_sg_id
  private_instance_1_id = module.instances.private_instance_1_id
  private_instance_2_id = module.instances.private_instance_2_id
}


