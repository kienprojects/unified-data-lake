resource "aws_db_instance" "db" {
  allocated_storage    = 20
  db_name              = "madhatter-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "12345.678!Aa"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}
