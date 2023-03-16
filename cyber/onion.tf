resource "aws_instance" "onion" {
  ami                                  = var.deb_based
  instance_type                        = "c5a.large"
  key_name                             = aws_key_pair.key.key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.onion_private1.id
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.onion_private2.id
  }
  network_interface {
    device_index         = 2
    network_interface_id = aws_network_interface.onion_private3.id
  }
  tags                                 = {
    "Name" = "onionsrv"
  }
  root_block_device {
    delete_on_termination = true
    tags                                 = {
      "Name" = "Volume for onionsrv"
    }
    volume_size           = 30
    volume_type           = "gp3"
  }
  user_data = data.template_file.onionsrv.rendered
}

resource "aws_network_interface" "onion_private1" {
  private_ips         = ["10.0.1.11"]
  security_groups    = [
    aws_security_group.cyber_default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.cyber_private1.id
  tags                                 = {
    "Name" = "Onion private1 interface"
  }
}

resource "aws_network_interface" "onion_private2" {
  private_ips         = ["10.0.2.11"]
  security_groups    = [
    aws_security_group.cyber_default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.cyber_private2.id
  tags                                 = {
    "Name" = "Onion private2 interface"
  }
}

resource "aws_network_interface" "onion_private3" {
  private_ips         = ["10.0.3.11"]
  security_groups    = [
    aws_security_group.cyber_default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.cyber_private3.id
  tags                                 = {
    "Name" = "Onion private3 interface"
  }
}
