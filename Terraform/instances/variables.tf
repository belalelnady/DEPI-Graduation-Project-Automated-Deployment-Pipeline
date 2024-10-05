# variable "private_data" {
#    type        = map(object({
#     ami_id          = string
#     instance_type   = string
#     subnet_id       = string
#     security_group_id = string
#     key_name        = string
#   }))
# }


variable "ami_id" {
  type        = string
}

variable "instance_type" {
  type        = string
}

variable "public_subnet_id" {
  type        = string
}

variable "private_subnet_1_id" {
  type        = string
}

variable "private_subnet_2_id" {
  type        = string
}

variable "bastion_sg_id" {
  type        = string
}

variable "private_sg_id" {
  type        = string
}

variable "key_name" {
  type        = string
}