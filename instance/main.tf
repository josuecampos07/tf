provider "aws" {
  region = "us-east-1"
  access_key = var.access_key 
  secret_key = var.secret_key 
}


resource "aws_instance" "second-server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = var.tags
  security_groups = [ aws_security_group.ssh_connection.name ]
  }


resource "aws_security_group" "ssh_connection" {
    name        = var.sg
    dynamic "ingress"{
        for_each = var.ingress_rules
        content {
            from_port        = ingress.value.from_port
            to_port          = ingress.value.to_port
            protocol         = ingress.value.protocol
            cidr_blocks      = ingress.value.cidr_blocks
        }
    }
}