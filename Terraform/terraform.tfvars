subnet_data = {
  public-subnet1 = {
    cidr              = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_value         = true
  }
  public-subnet2 = {
    cidr              = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_value         = true
  }

  private-subnet1 = {
    cidr              = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    map_value         = false
  }
  
  private-subnet2 = {
    cidr              = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    map_value         = false
  }

}
