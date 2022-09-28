terraform {
  required_version = ">= 0.12"
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.9"
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

  advertise_on_public {
    public_ip {
      name      = "telus-test"
      namespace = "l-singh"
      # tenant    = "f5-amer-sp"
    }
  }

  // One of the arguments from this list "api_definitions disable_api_definition api_definition" must be set

  # api_definition {
  #   name      = "test1"
  #   namespace = "staging"
  #   tenant    = "acmecorp"
  # }

  // One of the arguments from this list "no_challenge js_challenge captcha_challenge policy_based_challenge" must be set

  # policy_based_challenge {
  #   // One of the arguments from this list "default_captcha_challenge_parameters captcha_challenge_parameters" must be set
  #   default_captcha_challenge_parameters = true

  #   // One of the arguments from this list "no_challenge always_enable_js_challenge always_enable_captcha_challenge" must be set
  #   always_enable_captcha_challenge = true

  #   // One of the arguments from this list "js_challenge_parameters default_js_challenge_parameters" must be set
  #   default_js_challenge_parameters = true

  #   // One of the arguments from this list "default_mitigation_settings malicious_user_mitigation" must be set
  #   default_mitigation_settings = true

    # rule_list {
    #   rules {
    #     metadata {
    #       description = "Virtual Host for acmecorp website"
    #       disable     = true
    #       name        = "acmecorp-web"
    #     }

    #     spec {
    #       arg_matchers {
    #         invert_matcher = true

    #         // One of the arguments from this list "check_not_present item presence check_present" must be set
    #         presence = true

    #         name = "name"
    #       }

    #       // One of the arguments from this list "asn_matcher any_asn asn_list" must be set
    #       any_asn = true

  #         body_matcher {
  #           exact_values = ["['new york', 'london', 'sydney', 'tokyo', 'cairo']"]

  #           regex_values = ["['^new .*$', 'san f.*', '.* del .*']"]

  #           transformers = ["transformers"]
  #         }

  #         // One of the arguments from this list "disable_challenge enable_javascript_challenge enable_captcha_challenge" must be set
  #         enable_javascript_challenge = true

  #         // One of the arguments from this list "client_name client_selector client_name_matcher any_client" must be set
  #         any_client = true

  #         cookie_matchers {
  #           invert_matcher = true

  #           // One of the arguments from this list "presence check_present check_not_present item" must be set
  #           check_present = true
  #           name          = "Session"
  #         }

  #         domain_matcher {
  #           exact_values = ["['new york', 'london', 'sydney', 'tokyo', 'cairo']"]

  #           regex_values = ["['^new .*$', 'san f.*', '.* del .*']"]
  #         }

  #         expiration_timestamp = "0001-01-01T00:00:00Z"

  #         headers {
  #           invert_matcher = true

  #           // One of the arguments from this list "presence check_present check_not_present item" must be set
  #           presence = true

  #           name = "Accept-Encoding"
  #         }

  #         http_method {
  #           invert_matcher = true

  #           methods = ["['GET', 'POST', 'DELETE']"]
  #         }

  #         // One of the arguments from this list "any_ip ip_prefix_list ip_matcher" must be set
  #         any_ip = true

  #         path {
  #           exact_values = ["['/api/web/namespaces/project179/users/user1', '/api/config/namespaces/accounting/bgps', '/api/data/namespaces/project443/virtual_host_101']"]

  #           prefix_values = ["['/api/web/namespaces/project179/users/', '/api/config/namespaces/', '/api/data/namespaces/']"]

  #           regex_values = ["['^/api/web/namespaces/abc/users/([a-z]([-a-z0-9]*[a-z0-9])?)$', '/api/data/namespaces/proj404/virtual_hosts/([a-z]([-a-z0-9]*[a-z0-9])?)$']"]

  #           suffix_values = ["['.exe', '.shtml', '.wmz']"]

  #           transformers = ["transformers"]
  #         }

  #         query_params {
  #           invert_matcher = true
  #           key            = "sourceid"

  #           // One of the arguments from this list "presence check_present check_not_present item" must be set
  #           check_present = true
  #         }

  #         tls_fingerprint_matcher {
  #           classes = ["classes"]

  #           exact_values = ["['ed6dfd54b01ebe31b7a65b88abfa7297', '16efcf0e00504ddfedde13bfea997952', 'de364c46b0dfc283b5e38c79ceae3f8f']"]

  #           excluded_values = ["['fb00055a1196aeea8d1bc609885ba953', 'b386946a5a44d1ddcc843bc75336dfce']"]
  #         }
  #       }
  #     }
  #   }

  #   // One of the arguments from this list "default_temporary_blocking_parameters temporary_user_blocking" must be set
  #   default_temporary_blocking_parameters = true
  # }
  domains = ["foo.amer-sp.f5demos.com"]

  // One of the arguments from this list "http https_auto_cert https" must be set

  http {
    dns_volterra_managed = true
    port                 = "80"
  }

  ##########Mark Menger############

  bot_defense{
    policy {
      js_insert_all_pages{
        javascript_location = "AFTER_HEAD"
      }
      js_download_path = "/common.js"
      protected_app_endpoints{
        http_methods = ["Post"]
        metadata{
          name = "test"
        }
        mitigation{
          block{
            body = "Your request was blocked"
          }
        }
        path{
          prefix = "/"
        }
      }
    }
    regional_endpoint = "US"
  }


  ############Lakhwinder###############
  # bot_defense{
  #   policy {
  #     js_insert_all_pages{
  #       javascript_location = "After <head> tag"
  #     }
  #     js_download_path = "/common.js"
  #     protected_app_endpoints{
  #       mobile = "true"
  #       http_methods = ["Mark"]
  #       metadata{
  #         name = "test"
  #       }
  #       mitigation{
  #         block{
  #           body = "Your request was blocked"
  #         }
  #       }
  #       path{
  #         prefix = "/"
  #       }
  #     }

  #   }
  #   regional_endpoint = "US"

  # }

  app_firewall {
    name      = "acmecorp-web"
    namespace = "l-singh"
    # tenant    = "acmecorp"
  }
}