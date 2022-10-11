// Required Variable
variable "api_p12_file" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "/Users/l.singh/Downloads/f5-amer-sp.console.ves.volterra.io.api-creds.p12"
}

variable "api_cert" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "/Users/l.singh/Downloads/f5xc.cert"
}
variable "api_key" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "/Users/l.singh/Downloads/f5xc.key"
}
// Required Variable
variable "tenant_name" {
  type        = string
  description = "REQUIRED:  This is your volterra Tenant Name:  https://<tenant_name>.console.ves.volterra.io/api"
  default     = "https://f5-amer-sp.console.ves.volterra.io/api"
}
// Required Variable
variable "namespace" {
  type        = string
  description = "REQUIRED:  This is your volterra App Namespace"
  default     = "l-singh"
}
// Required Variable
variable "name" {
  type        = string
  description = "REQUIRED:  This is name for your deployment"
  default     = "lak-terrafrom"
}

// Required Variable
variable "xcs_tf_action" {
  default = "plan"
}
variable "delegated_dns_domain" {
  default = "amer-sp.f5demos.com"
}
// Required Variable
variable "api_url" {
  type        = string
  description = "REQUIRED:  This is your volterra API url"
  default     = "https://f5-amer-sp.console.ves.volterra.io/api"
}
