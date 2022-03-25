variable "private_sdn_network" {
  type    = string
  default = ""
}

variable "zone" {
  type = string
}

variable "dbaas_plan" {
  type = string
}

variable "sqlproxy_plan" {
  type = string
}

variable "ssh_key_public" {
  type = string
}

variable "dbaas_mysql_master_host" {
  type    = string
  default = ""
}

variable "dbaas_mysql_replica_host" {
  type    = string
  default = ""
}

variable "dbaas_mysql_port" {
  type    = string
  default = ""
}

variable "dbaas_mysql_database" {
  type    = string
  default = ""
}

variable "dbaas_mysql_username" {
  type    = string
  default = ""
}

variable "dbaas_mysql_password" {
  type    = string
  default = ""
}

variable "dbaas_mysql_default_username" {
  type    = string
  default = ""
}

variable "dbaas_mysql_default_password" {
  type    = string
  default = ""
}

variable "sqlproxy_sdn_ip" {
  type    = string
  default = ""
}
