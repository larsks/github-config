resource "github_repository" "issues" {
  name        = "issues"
  visibility  = "private"
  description = "Issues related to AI in a Box project"
  has_issues  = true
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

resource "github_repository" "docs" {
  name        = "docs"
  visibility  = "public"
  description = "General documentation for the AI in a Box project"
  has_issues  = true
  auto_init   = true
}

resource "github_issue_labels" "docs" {
  repository = "docs"

  dynamic "label" {
    for_each = local.common_labels
    content {
      name        = label.value.name
      color       = label.value.color
      description = label.value.description
    }
  }
}

resource "github_branch_protection" "docs" {
  repository_id = "docs"

  pattern                 = "main"
  required_linear_history = true

  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}
