resource "aws_db_instance" "mysql" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "admin"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.subnetgroup.name
}
resource "aws_db_instance" "mysqlreplica" {
  replicate_source_db         = aws_db_instance.mysql.identifier
  instance_class              = "db.t2.micro"
  replica_mode                = "mounted"
  auto_minor_version_upgrade  = false
  custom_iam_instance_profile = "AWSRDSCustomInstanceProfile" # Instance profile is required for Custom for Oracle. See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-setup-orcl.html#custom-setup-orcl.iam-vpc
  backup_retention_period     = 7
  identifier                  = "ee-instance-replica"
  multi_az                    = false # Custom for Oracle does not support multi-az
  skip_final_snapshot         = true
  storage_encrypted           = true
}