variable "AWS_REGION" {
    default = "us-east-2"
}

variable "availability-zone1" {
  default = "us-east-2a"
}

variable "availability-zone2" {
  default = "us-east-2b"
}
variable "instance_accesskey" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = ""
}
variable "instance_secretkey" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = ""
}
variable "sg_ingress_rules" {
  description = "Ingress security group rules"
  type        = map
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}


variable "subnet1" {
  default = "10.0.1.0/24"
}
variable "subnet2" {
  default = "10.0.3.0/24"
}
variable "cidr_block2" {
  default = "0.0.0.0/0"
}

variable "lb_instance" {
  default = "ami-0fb653ca2d3203ac1"
}




variable "ami" {
  default = "ami-008e1e7f1fcbe9b80"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_count" {
  type = number
  default = "1"
}

variable "key_name" {
  default = "test"
}

variable "tags" {
description = "terraform instance tag name"
type = map(string)
default     = {
                    Terraform   = "ELB"
                    Environment = "TEST"
  }
}
