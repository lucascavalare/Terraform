# Outputing MySQL Address 
output "address" {
  value = "${aws_db_instance.mysqldb.address}"
}

# Outputing MySQL Port
output "port" {
  value = "${aws_db_instance.mysqldb.port}"
}
