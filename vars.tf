variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "AMIS" {
  type = map(string)
  default = {
      eu-central-1 = "ami-0b418580298265d5c"
      eu-west-1 = "ami-035966e8adab4aaad"
      eu-west-2 = "ami-006a0174c6c25ac06"
      eu-west-3 = "ami-096b8af6e7e8fb927"
      ue-north-1 = "ami-0b7937aeb16a7eb94"
  }
}