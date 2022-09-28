# main.tf

# Util Module
# - Random Prefix Generation
# - Random Password Generation
module "origin" {
  source           = "./origin"
  api_url          = "${var.api_url}"
  api_p12_file     = "${var.api_p12_file}"
  api_cert         = "${var.api_cert}"
  api_key          = "${var.api_key}"
}
# module "site" {
#   source           = "./site"
#   api_url          = "${var.api_url}"
#   api_p12_file     = "${var.api_p12_file}"
#   api_cert         = "${var.api_cert}"
#   api_key          = "${var.api_key}"
# }