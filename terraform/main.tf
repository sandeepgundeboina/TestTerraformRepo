resource "local_file" "config" {
  filename = "${path.module}/output/${var.environment}-config.txt"
  content  = <<-EOT
    Application: AZFUNCHOSTING
    Environment: ${var.environment}
    Branch: ${var.branch_name}
    Last Updated by: ${var.last_updated_by}
    Timestamp: ${timestamp()}
    Version: ${var.app_version}
  EOT
}

resource "random_id" "app_id" {
  byte_length = 4
}

resource "local_file" "app_info" {
  filename = "${path.module}/output/${var.environment}-app-info.json"
  content = jsonencode({
    app_name    = "AZFUNCHOSTING"
    app_id      = random_id.app_id.hex
    environment = var.environment
    version     = var.app_version
    branch      = var.branch_name
    created_at  = timestamp()
  })
}

output "config_file_path" {
  value = local_file.config.filename
}

output "app_id" {
  value = random_id.app_id.hex
}
