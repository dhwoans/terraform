resource "aws_eip" "eip" {
  vpc = true
  
  lifecycle{
    create_before_destroy=true
  }
}