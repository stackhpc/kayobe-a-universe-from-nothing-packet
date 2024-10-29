terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
    null = {
      source = "hashicorp/null"
    }
    tls = {
      source = "hashicorp/tls"
    }
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "2.1.0"
    }
  }
  required_version = ">= 0.13"
}
