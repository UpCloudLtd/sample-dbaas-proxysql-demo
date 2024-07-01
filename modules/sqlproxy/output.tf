output "sqlproxy_sdn_ip" {
  value = upcloud_server.sql-proxy-server.network_interface[1].ip_address
}

output "proxy_ip_addresses" {
  value = upcloud_server.sql-proxy-server.network_interface[0].ip_address
}