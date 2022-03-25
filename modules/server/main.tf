resource "upcloud_server" "sql-client" {
  hostname   = "sql-client"
  zone       = var.zone
  plan       = "1xCPU-1GB"
  depends_on = [var.private_sdn_network, var.dbaas_mysql_username, var.sqlproxy_sdn_ip]

  template {
    storage = "Ubuntu Server 20.04 LTS (Focal Fossa)"
    size    = 25
  }
  network_interface {
    type = "public"
  }
  network_interface {
    type    = "private"
    network = var.private_sdn_network
  }

  login {
    user = "root"
    keys = [
      var.ssh_key_public,
    ]
    create_password   = false
    password_delivery = "email"
  }

  connection {
    host  = self.network_interface[0].ip_address
    type  = "ssh"
    user  = "root"
    agent = true
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get -y install sysbench mysql-client-core-8.0",
      "echo 'sysbench /usr/share/sysbench/oltp_read_write.lua --threads=1 --mysql-host=${var.sqlproxy_sdn_ip} --mysql-user=${var.dbaas_mysql_username} --mysql-password=${var.dbaas_mysql_password} --mysql-port=6033 --mysql-db=${var.dbaas_mysql_database} --db-driver=mysql --tables=10 --table-size=100000  prepare' > /root/prepare-benchmark",
      "echo 'sysbench /usr/share/sysbench/oltp_read_write.lua --threads=1 --mysql-host=${var.sqlproxy_sdn_ip} --mysql-user=${var.dbaas_mysql_username} --mysql-password=${var.dbaas_mysql_password} --mysql-port=6033 --mysql-db=${var.dbaas_mysql_database} --db-driver=mysql --tables=10 --table-size=100000 --report-interval=10 --time=60 run' > /root/run-benchmark",
      "echo 'while true; do mysql -h ${var.sqlproxy_sdn_ip} -P6033 -u${var.dbaas_mysql_username} -p${var.dbaas_mysql_password} -srNe \"SELECT @@hostname\"; sleep 1; done' > /root/ping-mysql.sh"
    ]
  }
}
