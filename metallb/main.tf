locals {
    metallb_version      = "0.14.4"
    metallb_ip_addr_pool = "192.168.50.230-192.168.50.235"
}

data "http" "metallb_ingress_manifests" {
  url = "https://raw.githubusercontent.com/metallb/metallb/v${local.metallb_version}/config/manifests/metallb-native.yaml"
}

data "kubectl_file_documents" "metallb_ingress_manifests" {
  content = data.http.metallb_ingress_manifests.response_body
}

resource "kubectl_manifest" "metallb_ingress_manifests" {
  count     = length(data.kubectl_file_documents.metallb_ingress_manifests.documents)
  yaml_body = element(data.kubectl_file_documents.metallb_ingress_manifests.documents, count.index)
}

resource "kubectl_manifest" "metallb_ip_addr_pool" {
  depends_on = [ kubectl_manifest.metallb_ingress_manifests ]
  yaml_body  = <<YAML
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: k3s-lb-pool
  namespace: metallb-system
spec:
  addresses:
  - ${local.metallb_ip_addr_pool}
YAML
}

resource "kubectl_manifest" "metallb_l2_advertisement" {
  depends_on = [ kubectl_manifest.metallb_ingress_manifests ]
  yaml_body  = <<YAML
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: k3s-lb-pool
  namespace: metallb-system
YAML
}