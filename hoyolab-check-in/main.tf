resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "hoyolab-check-in"
  }
}

resource "helm_release" "hoyolab_check_in" {
  name       = "hoyolab-check-in"
  repository = "https://dqle.github.io/helm-charts/"
  chart      = "hoyolab-check-in"
  namespace  = kubernetes_namespace.namespace.id

  values = [ "${file("values.yaml")}" ]
}