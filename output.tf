output "sql_client_ip_address" {
  value = module.server.sql_client_ip_address
}

output "proxy_ip_addresses" {
  value = module.sqlproxy.proxy_ip_addresses
}