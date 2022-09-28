
resource "volterra_gcp_vpc_site" "example" {
  name      = "acmecorp-web"
  namespace = "l-singh"

  // One of the arguments from this list "default_blocked_services blocked_services" must be set
  default_blocked_services = true

  // One of the arguments from this list "cloud_credentials" must be set

  cloud_credentials {
    name      = "ls-gcp"
    namespace = "l-singh"
    # tenant    = "acmecorp"
  }
  gcp_region    = ["us-west1"]
  instance_type = ["n1-standard-4"]
  // One of the arguments from this list "logs_streaming_disabled log_receiver" must be set
  logs_streaming_disabled = true

  // One of the arguments from this list "ingress_gw ingress_egress_gw voltstack_cluster" must be set

  voltstack_cluster {
    // One of the arguments from this list "no_dc_cluster_group dc_cluster_group" must be set
    no_dc_cluster_group = true

    // One of the arguments from this list "no_forward_proxy active_forward_proxy_policies forward_proxy_allow_all" must be set
    forward_proxy_allow_all = true
    gcp_certified_hw        = "gcp-byol-voltstack-combo"

    gcp_zone_names = ["us-west1-a, us-west1-b, us-west1-c"]

    // One of the arguments from this list "no_global_network global_network_list" must be set
    no_global_network = true

    // One of the arguments from this list "no_k8s_cluster k8s_cluster" must be set
    no_k8s_cluster = true

    // One of the arguments from this list "no_network_policy active_network_policies" must be set
    no_network_policy = true
    node_number       = "1"

    // One of the arguments from this list "no_outside_static_routes outside_static_routes" must be set

    outside_static_routes {
      static_route_list {
        // One of the arguments from this list "simple_static_route custom_static_route" must be set
        simple_static_route = "10.5.1.0/24"
      }
    }
    site_local_network {
      // One of the arguments from this list "new_network_autogenerate new_network existing_network" must be set

      new_network_autogenerate {
        autogenerate = true
      }
    }
    site_local_subnet {
      // One of the arguments from this list "new_subnet existing_subnet" must be set

      new_subnet {
        primary_ipv4 = "10.1.0.0/16"
        subnet_name  = "subnet1-in-network1"
      }
    }
    // One of the arguments from this list "sm_connection_public_ip sm_connection_pvt_ip" must be set
    sm_connection_public_ip = true
    // One of the arguments from this list "default_storage storage_class_list" must be set
    default_storage = true
  }
}