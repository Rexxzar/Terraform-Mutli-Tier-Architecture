resource "aws_launch_template" "tier1" {

  name = var.launchtempname1




  image_id = var.ami-image





  instance_type = var.instance_type



  key_name = var.keyname





  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.asg_sg-tier-1.id]
  }


  tag_specifications {


    tags = {
      Name = "first tier launch template"
    }
  }
  user_data = filebase64("user-data.sh")
}
resource "aws_launch_template" "tier2" {

  name = var.launchtempname2




  image_id = var.ami-image





  instance_type = var.instance_type



  key_name = var.keyname





  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.asg_sg-second.id]
  }


  tag_specifications {


    tags = {
      Name = "second tier launch template"
    }
  }

}



