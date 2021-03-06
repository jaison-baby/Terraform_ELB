provider "aws" {
    region = var.AWS_REGION
    access_key = var.instance_accesskey
    secret_key = var.instance_secretkey
}

resource "aws_instance" "nginx_server" { 
  ami  = var.ami
  instance_type = var.instance_type
  count    = var.ec2_count
  key_name = var.key_name
  tags = var.tags
  subnet_id = module.vpc.subnetid
  vpc_security_group_ids = [module.SG.sgid]
  user_data = <<-EOF
             #!/bin/bash
             sudo yum install httpd -y
             sudo systemctl start httpd.service
             EOF
}

resource "aws_eip" "nginx_eip" {
  vpc        = true
 

  instance = aws_instance.nginx_server[0].id
  depends_on = [module.vpc.gatewayid]

}

module "vpc" {
 source  = "./modules/vpc"
 availability-zone1 = var.availability-zone1
 availability-zone2 = var.availability-zone2
 cidr_block = var.cidr_block
 subnet1 = var.subnet1
 subnet2 = var.subnet2
 cidr_block2 = var.cidr_block2
 }
 
module "SG" {

source  = "./modules/SG"
a_vpc_id            =  module.vpc.vpcid
sg_ingress_rules = var.sg_ingress_rules
availability-zone1 = var.availability-zone1

}
module "acm" {
     source = "./modules/ACM"
     alb_dns = module.ELB.elb_dns
     alb_zone_id = module.ELB.elb_zone_id
}
module "ELB" {
    source = "./modules/elb"
    lb_sg  = module.SG.sgid
    lb_subnet = module.vpc.subnetid
    lb_subnet2 = module.vpc.subnetid2
    lb_vpc     = module.vpc.vpcid
    lb_instance = aws_instance.nginx_server[0].id
    acm_certificate = module.acm.acm_cert
}
