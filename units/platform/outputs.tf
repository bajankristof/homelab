output "storage_class_name" {
  value = kubernetes_storage_class_v1.default.metadata[0].name
}
