terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

resource "github_repository" "repo" {
  name          = var.name
  visibility    = var.visibility
  description   = var.description
  auto_init     = true
  has_issues    = true
  has_downloads = false
  has_projects  = false
  has_wiki      = false
}

resource "github_issue_labels" "repo_labels" {
  repository = var.name

  dynamic "label" {
    for_each = local.labels
    content {
      name        = label.value.name
      color       = label.value.color
      description = label.value.description
    }
  }

  depends_on = [github_repository.repo]
}

resource "github_branch_protection" "repo_protection" {
  # This odd looking construct lets us control the creation of the
  # branch protection resource with a boolean variable.
  count         = var.branch_protection ? 1 : 0
  repository_id = var.name

  pattern                 = "main"
  required_linear_history = true

  required_pull_request_reviews {
    required_approving_review_count = 1
  }

  depends_on = [github_repository.repo]
}

