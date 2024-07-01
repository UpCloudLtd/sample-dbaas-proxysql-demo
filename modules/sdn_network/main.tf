resource "upcloud_network" "private_sdn_network" {
  name = "sqlproxy-sdn-network"
  zone = var.zone

  ip_network {
    address            = "10.10.11.0/24"
    dhcp               = true
    dhcp_default_route = false
    family             = "IPv4"
  }
}
resource "upcloud_router" "mysql_be_router" {
  name = "mysql_be_router"
}
resource "upcloud_network" "private_mysql_be" {
  name   = "mysql-backend-network"
  zone   = var.zone
  router = upcloud_router.mysql_be_router.id
  ip_network {
    address            = "10.10.21.0/24"
    dhcp               = true
    dhcp_default_route = false
    family             = "IPv4"
  }
}