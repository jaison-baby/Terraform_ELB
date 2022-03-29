variable "domain" {
  description = "Name of the s3 bucket. Must be unique."
  default        = "terraformcloudfront.tk"
}

variable "alb_dns" {
  description = "new alb dns"
}
variable "alb_zone_id" {
  description = "new alb zone"
}
