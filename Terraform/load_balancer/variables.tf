variable "vpc_id" {
  description = "VPC ID where the load balancer will be created"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for the load balancer"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security group ID for the load balancer"
  type        = string
}

variable "private_instance_1_id" {
  description = "Instance ID of the first private instance"
  type        = string
}

variable "private_instance_2_id" {
  description = "Instance ID of the second private instance"
  type        = string
}
