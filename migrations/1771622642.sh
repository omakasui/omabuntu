echo "Add SSH flakiness fix to sysctl.conf"
echo "net.ipv4.tcp_mtu_probing=1" | sudo tee -a /etc/sysctl.d/99-sysctl.conf