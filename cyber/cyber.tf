resource "aws_key_pair" "key" {
  key_name   = "Redes"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2W6MG+b8k9HKNMRyQksi+S2XBryBNK9uj4DkXu542Hf4hd32zCFnlNbik3EDOE8EKeg8S6IvJGdTeBLYraxize2tm5DMGz6LMeWmyK+OK/EDxYtRpJMXC7Dk3rbRdsRZyvqqmQmP5hJEV5A0zLUYwgm6cIxGa1a+671AG2cX170qbmdb3OzajlccaEIq0QexBoBM2kDpu3kG4aeLKShbp9Pjj290tRFvVMEqwi8Ay8KdQY8Sg1f8QTdJe9F5icACm4SLkfTiSw0sB7nDInNj3R4/Q7yn4Hx65K5uG8jXUGTsHdWcFgrm/naWJ3yfxoNOQayZlX44lL4rsiy7w/HPZR2MBFcYAJxfDG0Pam6fXnQr7MHZ/XK0QaP2vvPbmlifPaJQMEAfOvZxhRS7CLmFawbqokxsO+62ADB/38ycxD0Hq2Q1LF9+f4f17Tq8JRssYFkdzM63l0tnQhbyZM6g+J3VMgovSHu3jBHLZ9wIhilndQvQNtecIqVGzGposdBp0c/USF4km12xk/RXsQnWnbp+8fNcdiSF3dkF0p+dIdfHIuTH5GnmzP9187K3FZu0gueQJuU5Lx0IP+6TEZgSrDJgElx6PJCPzIv6/2OL3QdmhzwcFN3L/xq0GF4GMGxeGGouVQjRKo+Q3u3PLezVoAgAlnAd3qAikP82VA2358w=="
}

resource "aws_vpc" "cyber" {
  cidr_block                           = "10.0.0.0/16"
  tags                                 = {
    "Name" = "Cyber"
  }
}

resource "aws_subnet" "cyber_private1" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "10.0.1.0/24"
  tags                                           = {
    "Name" = "cyber-subnet-pdl_private1"
  }
  vpc_id                                         = aws_vpc.cyber.id
}

resource "aws_subnet" "cyber_private2" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "10.0.2.0/24"
  tags                                           = {
    "Name" = "cyber-subnet-pdl_private2"
  }
  vpc_id                                         = aws_vpc.cyber.id
}

resource "aws_subnet" "cyber_private3" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "10.0.3.0/24"
  tags                                           = {
    "Name" = "cyber-subnet-pdl_private3"
  }
  vpc_id                                         = aws_vpc.cyber.id
}

resource "aws_subnet" "cyber_private4" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "10.0.4.0/24"
  tags                                           = {
    "Name" = "cyber-subnet-pdl_private4"
  }
  vpc_id                                         = aws_vpc.cyber.id
}

resource "aws_subnet" "cyber_public1" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "10.0.0.0/24"
  tags                                           = {
    "Name" = "cyber-subnet-pdl_public1"
  }
  vpc_id                                         = aws_vpc.cyber.id
}

resource "aws_internet_gateway" "cyber-igw" {
  tags     = {
    "Name" = "cyber-igw"
  }
  vpc_id   = aws_vpc.cyber.id
}

resource "aws_route_table" "cyber_private1" {
  tags             = {
    "Name" = "cyber-rtb-pdl_private1"
  }
  vpc_id           = aws_vpc.cyber.id
}

resource "aws_route_table" "cyber_private2" {
  tags             = {
    "Name" = "cyber-rtb-pdl_private2"
  }
  vpc_id           = aws_vpc.cyber.id
}

resource "aws_route_table" "cyber_private3" {
  tags             = {
    "Name" = "cyber-rtb-pdl_private3"
  }
  vpc_id           = aws_vpc.cyber.id
}

resource "aws_route_table" "cyber_private4" {
  tags             = {
    "Name" = "cyber-rtb-pdl_private4"
  }
  vpc_id           = aws_vpc.cyber.id
}

resource "aws_route_table" "cyber_public1" {
  vpc_id = aws_vpc.cyber.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cyber-igw.id
  }
  tags             = {
    "Name" = "cyber-rtb-public"
  }
}

resource "aws_route_table_association" "cyber_private1" {
  route_table_id = aws_route_table.cyber_private1.id
  subnet_id      = aws_subnet.cyber_private1.id
}

resource "aws_route_table_association" "cyber_private2" {
  route_table_id = aws_route_table.cyber_private2.id
  subnet_id      = aws_subnet.cyber_private2.id
}

resource "aws_route_table_association" "cyber_private3" {
  route_table_id = aws_route_table.cyber_private3.id
  subnet_id      = aws_subnet.cyber_private3.id
}

resource "aws_route_table_association" "cyber_private4" {
  route_table_id = aws_route_table.cyber_private4.id
  subnet_id      = aws_subnet.cyber_private4.id
}

resource "aws_route_table_association" "cyber_public1" {
  route_table_id = aws_route_table.cyber_public1.id
  subnet_id      = aws_subnet.cyber_public1.id
}

resource "aws_vpc_endpoint" "cyber-vpce-s3" {
  policy                = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
      Version   = "2008-10-17"
    }
  )
  route_table_ids       = [
    aws_route_table.cyber_private1.id,
    aws_route_table.cyber_private2.id,
    aws_route_table.cyber_private3.id,
    aws_route_table.cyber_private4.id,
  ]
  service_name          = var.vpc_ep_svc_name
  tags                  = {
    "Name" = "cyber-vpce-s3"
  }
  vpc_endpoint_type     = "Gateway"
  vpc_id                = aws_vpc.cyber.id
}

resource "aws_security_group" "cyber_default" {
  description = "Cyber default VPC security group"
  egress      = [
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress     = [
    {
      cidr_blocks      = [
        "192.168.0.0/16",
        "172.16.0.0/12",
        "10.0.0.0/8",
      ]
      description      = "RFC 1918"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    },
  ]
  name        = "cyber_default"
  tags        = {
    "Name" = "Cyber"
  }
  vpc_id      = aws_vpc.cyber.id
}

resource "aws_vpc_security_group_ingress_rule" "cyber_enta" {
  cidr_ipv4              = "185.218.12.73/32"
  description            = "ENTA"
  ip_protocol            = "-1"
  security_group_id      = aws_security_group.cyber_default.id
  tags                   = {
    "Name" = "ENTA IP address"
  }
}

resource "aws_vpc_security_group_ingress_rule" "cyber_enta_meo" {
  cidr_ipv4              = "83.240.158.54/32"
  description            = "ENTA MEO"
  ip_protocol            = "-1"
  security_group_id      = aws_security_group.cyber_default.id
  tags                   = {
    "Name" = "ENTA MEO IP address"
  }
}

resource "aws_vpc_security_group_ingress_rule" "cyber_home" {
  cidr_ipv4              = "78.29.148.171/32"
  description            = "HOME"
  ip_protocol            = "-1"
  security_group_id      = aws_security_group.cyber_default.id
  tags                   = {
    "Name" = "My IP address"
  }
}

resource "aws_instance" "luxsrv_cyber_local" {
  ami                                  = var.deb_based
  instance_type                        = "c5a.large"
  key_name                             = aws_key_pair.key.key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.luxsrv_cyber_public1.id
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.luxsrv_cyber_private1.id
  }
  network_interface {
    device_index         = 2
    network_interface_id = aws_network_interface.luxsrv_cyber_private2.id
  }
  tags                                 = {
    "Name" = "luxsrv.cyber.local"
  }
  root_block_device {
    delete_on_termination = true
    tags                                 = {
      "Name" = "Volume for luxsrv.cyber.local"
    }
    volume_size           = 30
    volume_type           = "gp3"
  }
  user_data = data.template_file.luxsrv-cyber-local.rendered
}

resource "aws_network_interface" "luxsrv_cyber_private1" {
  private_ips         = ["10.0.1.10"]
  security_groups    = [
    aws_security_group.cyber_default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.cyber_private1.id
  tags                                 = {
    "Name" = "Cyber private1 interface"
  }
}

resource "aws_network_interface" "luxsrv_cyber_private2" {
  private_ips         = ["10.0.2.10"]
  security_groups    = [
    aws_security_group.cyber_default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.cyber_private2.id
  tags                                 = {
    "Name" = "Cyber private2 interface"
  }
}

resource "aws_network_interface" "luxsrv_cyber_public1" {
  private_ips         = ["10.0.0.10"]
  security_groups    = [
    aws_security_group.cyber_default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.cyber_public1.id
  tags                                 = {
    "Name" = "Cyber public interface"
  }
}

resource "aws_eip" "cyber_public_ip" {
  vpc                       = true
  network_interface         = aws_network_interface.luxsrv_cyber_public1.id
  tags                                 = {
    "Name" = "Cyber public IP"
  }
  depends_on = [
    aws_instance.luxsrv_cyber_local
  ]
}

