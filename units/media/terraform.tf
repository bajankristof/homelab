terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.1"
    }

    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.26"
    }
  }
}
