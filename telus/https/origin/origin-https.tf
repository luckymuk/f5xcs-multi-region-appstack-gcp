terraform {
  #required_version = ">= 0.12"
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.13"
    }
  }
}
provider "volterra" {
  api_p12_file = "${var.api_p12_file}"
  api_cert     = "${var.api_cert}"
  api_key      = "${var.api_key}"
  # api_ca_cert  = "${var.api_ca_cert}"
  url          = "${var.api_url}"
}
data "local_file" "cert" {
  filename = "${path.module}/cert/cert.pem"
}
data "local_file" "key" {
  filename = "${path.module}/cert/key.pem"
}
resource "volterra_origin_pool" "example" {
  name                   = "acmecorp-web"
  namespace              = "l-singh"
  endpoint_selection     = "local_endpoints_preffered"
  loadbalancer_algorithm = "loadbalancer_override"
  
  healthcheck {         
  name = "telus-test"
  namespace = "l-singh"
  }

  origin_servers {
    // One of the arguments from this list "public_name k8s_service vn_private_ip public_ip private_name consul_service custom_endpoint_object vn_private_name private_ip" must be set

    // private_ip {
    //   ip = "8.8.8.8"
    k8s_service {
      service_name = "star-ratings-app.default"

      // One of the arguments from this list "inside_network outside_network" must be set
      outside_network = true

      site_locator {
        // One of the arguments from this list "site virtual_site" must be set

        site {
          name = "ce-gke-telus"
          namespace = "system"
          # tenant = "f5-amer-sp"
        }
      }
    }

    // labels = {
    //   "key1" = "value1"
    // }
  }

  port = "8080"

  // One of the arguments from this list "no_tls use_tls" must be set
  no_tls = true
}
resource "volterra_healthcheck" "example" {
  name      = "telus-test"
  namespace = "l-singh"

  // One of the arguments from this list "http_health_check tcp_health_check" must be set

  http_health_check {
    # headers = {
    #   "key1" = "value1"
    # }

    // One of the arguments from this list "use_origin_server_name host_header" must be set
    use_origin_server_name = true
    path                   = "/"

    # request_headers_to_remove = ["user-agent"]
    # use_http2                 = true
  }
  healthy_threshold   = "2"
  interval            = "10"
  timeout             = "1"
  unhealthy_threshold = "5"
}
resource "volterra_app_firewall" "example" {
  name      = "acmecorp-web"
  namespace = "l-singh"

  // One of the arguments from this list "allow_all_response_codes allowed_response_codes" must be set
  allow_all_response_codes = true

  // One of the arguments from this list "disable_anonymization default_anonymization custom_anonymization" must be set
  default_anonymization = true

  // One of the arguments from this list "use_default_blocking_page blocking_page" must be set
  use_default_blocking_page = true

  // One of the arguments from this list "default_bot_setting bot_protection_setting" must be set
  default_bot_setting = true

  // One of the arguments from this list "default_detection_settings detection_settings" must be set
  default_detection_settings = true

  // One of the arguments from this list "use_loadbalancer_setting blocking monitoring" must be set
  blocking = true
}



resource "volterra_http_loadbalancer" "example" {
  name      = "acmecorp-web"
  namespace = "l-singh"

  // One of the arguments from this list "do_not_advertise advertise_on_public_default_vip advertise_on_public advertise_custom" must be set


advertise_custom{
  advertise_where{
    site{
      network = "SITE_NETWORK_OUTSIDE"
      site{
        name = "ce-gke-telus"
        namespace = "system"
      }
    }
  }
}
  # advertise_on_public {
  #   public_ip {
  #     name      = "telus-test"
  #     namespace = "l-singh"
  #     # tenant    = "f5-amer-sp"
  #   }
  # }
  # advertise_on_public_default_vip = true


  domains = ["foo.default","foo.kundalkanthi.com"]

  // One of the arguments from this list "http https_auto_cert https" must be set

  https {
    #dns_volterra_managed = false
    port                 = "443"
    http_redirect        = true
    tls_parameters {
      tls_certificates{
        certificate_url = format("string:///%s", data.local_file.cert.content_base64)
        private_key{
        clear_secret_info{
          url = format("string:///%s", data.local_file.key.content_base64)
       }
      }
      }
      tls_config{

      }

    }
  }

  default_route_pools{
    pool{
      name      = "acmecorp-web"
      namespace = "l-singh"
    }
  }

  #########Support##############
  bot_defense{
    policy {
      js_insert_all_pages{
        javascript_location = "AFTER_HEAD"
      }
      js_download_path = "/common.js"
      protected_app_endpoints{
        http_methods = ["['GET', 'POST', 'DELETE']"]
        metadata{
          name = "test"
        }
        mitigation{
          block{
            body = "string:///VGhlIHJlcXVlc3RlZCBVUkwgd2FzIHJlamVjdGVkLiBQbGVhc2UgY29uc3VsdCB3aXRoIHlvdXIgYWRtaW5pc3RyYXRvci4="
            status = "OK"
          }
        }
        path{
          prefix = "/"
        }
      }
    }
    regional_endpoint = "US"
  }
  app_firewall {
    name      = "acmecorp-web"
    namespace = "l-singh"
    # tenant    = "acmecorp"
  }
  ##########Mark Menger############

  # bot_defense{
  #   policy {
  #     js_insert_all_pages{
  #       javascript_location = "AFTER_HEAD"
  #     }
  #     js_download_path = "/common.js"
  #     protected_app_endpoints{
  #       http_methods = ["Post"]
  #       metadata{
  #         name = "test"
  #       }
  #       path{
  #         prefix = "/"
  #       }
  #     }
  #   }
  #   regional_endpoint = "US"
  # }


  ############Lakhwinder###############
  # bot_defense{
  #   policy {
  #     js_insert_all_pages{
  #       javascript_location = "After <head> tag"
  #     }
  #     js_download_path = "/common.js"
  #     protected_app_endpoints{
  #       #mobile = "true"
  #       http_methods = ["Post"]
  #       metadata{
  #         name = "test"
  #       }
  #       mitigation{
  #         block{
  #           #body = "Your request was blocked"
  #           body = "string:///VGhlIHJlcXVlc3RlZCBVUkwgd2FzIHJlamVjdGVkLiBQbGVhc2UgY29uc3VsdCB3aXRoIHlvdXIgYWRtaW5pc3RyYXRvci4="	
  #           status = "OK"
  #         }
  #       }
  #       path{
  #         prefix = "/"
  #       }
  #     }

  #   }
  #   regional_endpoint = "US"

  # }
}