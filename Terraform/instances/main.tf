resource "aws_instance" "bastion" {
  ami                    = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = var.public_subnet_id
  security_groups       = [var.bastion_sg_id]
  key_name              = var.key_name

  tags = {
    Name = "Bastion Host"
  }


    user_data = <<-EOT
      #!/bin/bash
      sudo apt update -y
      sudo apt install -y python3-pip
      sudo python3 -m pip install ansible
      sudo apt install git-all
      sudo apt-get install openjdk-11-jdk -y
    EOT


  provisioner "local-exec" {
    command = <<-EOT
      #!/bin/bash
      echo '[bastion-host]' >> ../pinventory.ini
      echo ${self.public_ip} >> ../pinventory.ini
      chmod 600 ${pathexpand("~/.ssh/${var.key_name}.pem")}
      sleep 160
      scp -o StrictHostKeyChecking=no -i ${pathexpand("~/.ssh/${var.key_name}.pem")}  ${pathexpand("~/.ssh/${var.key_name}.pem")} ${path.module}/../inventroy.ini ${path.module}/scripts/ansible-agent.sh  ubuntu@${self.public_ip}:/home/ubuntu
    EOT
  }
  
}

resource "aws_instance" "private_instance_1" {
  ami                    = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = var.private_subnet_1_id
  security_groups       = [var.private_sg_id]
  key_name              = var.key_name

  # user_data = "${file("scripts/install-nginx.sh")}"


  tags = {
    Name = "Private Instance 1"
  }
  provisioner "local-exec" {
    command = <<-EOT
      #!/bin/bash
      echo '[private-ec2]' >> ../inventory.ini
      echo ${self.public_ip} >> ../inventory.ini
    EOT
  }

}

resource "aws_instance" "private_instance_2" {
  ami                    = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = var.private_subnet_2_id
  security_groups       = [var.private_sg_id]
  key_name              = var.key_name

  # user_data = "${file("scripts/install-nginx.sh")}"

  tags = {
    Name = "Private Instance 2"
  }

    provisioner "local-exec" {
      command = <<-EOT
      #!/bin/bash
      echo ${self.public_ip} >> ../inventory.ini
    EOT
  }
}
