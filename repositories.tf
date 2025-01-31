# Create infrastructure repository
resource "github_repository" "issues" {
  name        = "issues"
  description = "Issues related to AI in a Box project"
  has_issues  = true
}

resource "github_repository" "docs" {
  name       = "docs"
  has_issues = true
  auto_init  = true
}

resource "github_issue_labels" "issues" {
  repository = "issues"

  dynamic "label" {
    for_each = local.common_labels
    content {
      name        = label.value.name
      color       = label.value.color
      description = label.value.description
    }
  }
}

