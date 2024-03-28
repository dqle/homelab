locals {
    palworld_server_name = "Cuatroplegics"
    palworld_secrets_dir = "G:\\My Drive\\Terraform\\palworld\\palworld_secrets.json"

    resources_limits_cpu      = "4"
    resources_limits_memory   = "24Gi"
    resources_requests_cpu    = "4"
    resources_requests_memory = "8Gi"

    game_settings_death_penalty                 = "None"
    game_settings_base_camp_worker_max_num      = "20"
    game_settings_pal_egg_default_hatching_time = "0"
    game_settings_enable_fast_travel            = "True"
    game_settings_coop_player_max_num           = "16"

}

resource "kubernetes_namespace" "palworld" {
  metadata {
    name = "palworld"
  }
}

resource "helm_release" "palworld" {
  name       = "palworld"
  repository = "https://twinki14.github.io/palworld-server-chart"
  chart      = "palworld"
  namespace  = kubernetes_namespace.palworld.id

  values = [templatefile("values.yaml", {
    resources_limits_cpu      = local.resources_limits_cpu
    resources_limits_memory   = local.resources_limits_memory
    resources_requests_cpu    = local.resources_requests_cpu
    resources_requests_memory = local.resources_requests_memory

    palworld_server_name     = "Cuatroplegics"
    palworld_server_password = jsondecode(file(local.palworld_secrets_dir))["server_password"]
    discord_webhook_url      = jsondecode(file(local.palworld_secrets_dir))["discord_webhook_url"]

    game_settings_death_penalty                 = local.game_settings_death_penalty
    game_settings_base_camp_worker_max_num      = local.game_settings_base_camp_worker_max_num
    game_settings_pal_egg_default_hatching_time = local.game_settings_pal_egg_default_hatching_time
    game_settings_enable_fast_travel            = local.game_settings_enable_fast_travel
    game_settings_coop_player_max_num           = local.game_settings_coop_player_max_num
  })]
}