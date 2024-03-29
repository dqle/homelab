resource "kubernetes_namespace" "pi_hole" {
  metadata {
    name = "pi-hole"
  }
}

resource "helm_release" "pi_hole" {
  name       = "pi-hole"
  repository = "https://mojo2600.github.io/pihole-kubernetes/"
  chart      = "pihole"
  namespace  = kubernetes_namespace.pi_hole.id

  values = [templatefile("values.yaml", {
    service_loadbalancer_ip = "192.168.50.231"
  })]
}