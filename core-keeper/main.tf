resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "core-keeper"
  }
}

resource "helm_release" "core_keeper" {
  name       = "core-keeper-dedicated-server"
  repository = "https://dqle.github.io/helm-charts/"
  chart      = "core-keeper-dedicated-server"
  namespace  = kubernetes_namespace.namespace.id

  values = [ "${file("values.yaml")}" ]
}