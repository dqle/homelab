locals {
    nginx_version = "1.10.0"
}

data "http" "nginx_ingress_manifests" {
  url = "https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v${local.nginx_version}/deploy/static/provider/baremetal/deploy.yaml"
}

data "kubectl_file_documents" "nginx_ingress_manifests" {
  content = data.http.nginx_ingress_manifests.response_body
}

resource "kubectl_manifest" "nginx_ingress_manifests" {
  count     = length(data.kubectl_file_documents.nginx_ingress_manifests.documents)
  yaml_body = element(data.kubectl_file_documents.nginx_ingress_manifests.documents, count.index)
}