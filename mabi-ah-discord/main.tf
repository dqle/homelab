resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "mabi-ah-discord"
  }
}

resource "helm_release" "mabi_ah_discord" {
  name       = "mabi-ah-discord"
  repository = "https://dqle.github.io/helm-charts/"
  chart      = "mabi-ah-discord"
  namespace  = kubernetes_namespace.namespace.id

  values = [ "${file("values.yaml")}" ]
}