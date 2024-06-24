resource "aws_db_subnet_group" "subnetgroup" {
  name       = "dbgroup"
  subnet_ids = [aws_subnet.subnet5.id, aws_subnet.subnet6.id]
  tags = {
    name = "db subnet group"
  }

}