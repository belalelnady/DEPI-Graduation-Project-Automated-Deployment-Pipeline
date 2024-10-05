variable "subnet_data" {
  type = map(object({
    cidr              = string
    availability_zone = string
    map_value         = bool
  }))

}
