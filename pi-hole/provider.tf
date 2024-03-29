provider "helm" {
  kubernetes {
    config_path = "G:\\My Drive\\Terraform\\kubeconfig"
  }
}

provider "kubernetes" {
  config_path = "G:\\My Drive\\Terraform\\kubeconfig"
}

provider "kubectl" {
  config_path = "G:\\My Drive\\Terraform\\kubeconfig"
}