provider "kubernetes" {
  config_path = "~/.kube/config" # Path to your local kubeconfig
}

resource "kubernetes_namespace" "demo" {
  metadata {
    name = "terraform-demo"
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }
      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"
        }
      }
    }
  }
}
