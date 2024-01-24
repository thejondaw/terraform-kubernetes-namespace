resource "kubernetes_namespace" "example" {
  metadata {
    name        = var.namespace
    annotations = var.annotations
    labels      = var.labels
  }
}

resource "kubernetes_resource_quota" "example" {
  metadata {
    name      = "podlimit"
    namespace = var.namespace
  }
  spec {
    hard = {
      pods = var.podlimit
    }
    scopes = ["BestEffort"]
  }
}

resource "kubernetes_limit_range" "example" {
  metadata {
    name      = "terraform-example"
    namespace = var.namespace
  }
  spec {
    limit {
      type = "Pod"
      max = {
        cpu    = var.pod_max_cpu_limit
        memory = var.pod_max_mem_limit
      }
    }

    limit {
      type = "Container"
      default = {
        cpu    = var.container_max_cpu_limit
        memory = var.container_max_mem_limit
      }
    }
  }
}


