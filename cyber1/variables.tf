variable "public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2W6MG+b8k9HKNMRyQksi+S2XBryBNK9uj4DkXu542Hf4hd32zCFnlNbik3EDOE8EKeg8S6IvJGdTeBLYraxize2tm5DMGz6LMeWmyK+OK/EDxYtRpJMXC7Dk3rbRdsRZyvqqmQmP5hJEV5A0zLUYwgm6cIxGa1a+671AG2cX170qbmdb3OzajlccaEIq0QexBoBM2kDpu3kG4aeLKShbp9Pjj290tRFvVMEqwi8Ay8KdQY8Sg1f8QTdJe9F5icACm4SLkfTiSw0sB7nDInNj3R4/Q7yn4Hx65K5uG8jXUGTsHdWcFgrm/naWJ3yfxoNOQayZlX44lL4rsiy7w/HPZR2MBFcYAJxfDG0Pam6fXnQr7MHZ/XK0QaP2vvPbmlifPaJQMEAfOvZxhRS7CLmFawbqokxsO+62ADB/38ycxD0Hq2Q1LF9+f4f17Tq8JRssYFkdzM63l0tnQhbyZM6g+J3VMgovSHu3jBHLZ9wIhilndQvQNtecIqVGzGposdBp0c/USF4km12xk/RXsQnWnbp+8fNcdiSF3dkF0p+dIdfHIuTH5GnmzP9187K3FZu0gueQJuU5Lx0IP+6TEZgSrDJgElx6PJCPzIv6/2OL3QdmhzwcFN3L/xq0GF4GMGxeGGouVQjRKo+Q3u3PLezVoAgAlnAd3qAikP82VA2358w=="
}

variable "desktop_ami" {
  type = string
  default = "ami-0557a15b87f6559cf"
}

variable "onion_ami" {
type = string
default = "ami-09cd747c78a9add63"
}

variable "avail_zone" {
  type = string
  default = "us-east-1a"
}

variable "desktop_type" {
  type = string
  default = "c5a.large"
}

variable "onion_type" {
  type = string
  default = "t2.large"
}

variable "vpc_ep_svc_name" {
  type = string
  default = "com.amazonaws.us-east-1.s3"
}

variable "cloud_config_onion" {
  default = "cloud-config-onion.sh"
}

variable "cloud_config_desktop" {
  default = "cloud-config-desktop.sh"
}

variable "config-desktop" {
  default = "config-desktop.sh"
}

variable "config-onion" {
  default = "config-onion.sh"
}

variable "config-netplan" {
  default = "50-cloud-init.yaml.patch"
}



