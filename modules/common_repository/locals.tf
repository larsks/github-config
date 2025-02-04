locals {
  common_labels = csvdecode(file("${path.module}/labels.csv"))
  labels        = var.labels == null ? local.common_labels : var.labels
}
