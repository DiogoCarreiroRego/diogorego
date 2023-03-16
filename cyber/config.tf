data "template_file" "luxsrv" {
  template = <<EOF
#!/bin/bash
LOGFILE="/var/log/cloud-config-"$(date +%s)
SCRIPT_LOG_DETAIL="$LOGFILE"_$(basename "$0").log

# Reference: https://serverfault.com/questions/103501/how-can-i-fully-log-all-bash-scripts-actions
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>$SCRIPT_LOG_DETAIL 2>&1

hostnamectl set-hostname luxsrv
apt-get update
apt-get upgrade -y
apt install netfilter-persistent iptables-persistent net-tools -y
apt install -y xfce4 xfce4-goodies
apt install -y xrdp filezilla
snap install brave
adduser xrdp ssl-cert
echo "ubuntu:Passw0rd" | sudo chpasswd
echo xfce4-session > /home/ubuntu/.xsession
chown ubuntu:ubuntu /home/ubuntu/.xsession
systemctl enable --now xrdp
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
netfilter-persistent save
reboot
EOF
}

data "template_file" "onionsrv" {
  template = <<EOF
#!/bin/bash
LOGFILE="/var/log/cloud-config-"$(date +%s)
SCRIPT_LOG_DETAIL="$LOGFILE"_$(basename "$0").log

# Reference: https://serverfault.com/questions/103501/how-can-i-fully-log-all-bash-scripts-actions
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>$SCRIPT_LOG_DETAIL 2>&1

hostnamectl set-hostname onionsrv
apt-get update
apt-get upgrade -y
apt install -y xfce4 xfce4-goodies
apt install -y xrdp filezilla
snap install brave
adduser xrdp ssl-cert
echo "ubuntu:Passw0rd" | sudo chpasswd
echo xfce4-session > /home/ubuntu/.xsession
chown ubuntu:ubuntu /home/ubuntu/.xsession
systemctl enable --now xrdp
EOF
}