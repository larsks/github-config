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

resource "github_issue_label" "repo_labels" {
  repository = var.name

  # Generate label blocks from the value of local.values, which by default is initialized
  # by the contents of the "labels.csv" file.
  for_each = {
    for label in local.labels :
    label.name => label
  }

  name        = each.value.name
  color       = each.value.color
  description = each.value.description

  depends_on = [github_repository.repo]
}

resource "github_branch_protection" "repo_protection" {
  # This odd looking construct lets us control the creation of the
  # branch protection resource with a boolean variable.
  count = var.visibility == "private" ? 0 : var.branch_protection ? 1 : 0

  repository_id = var.name
  pattern       = "main"

  required_linear_history         = true
  allows_deletions                = false
  allows_force_pushes             = false
  enforce_admins                  = false
  require_conversation_resolution = false
  require_signed_commits          = false

  force_push_bypassers = [
    "innabox/org-admins",
  ]

  required_pull_request_reviews {
    required_approving_review_count = var.required_approvals
  }

  required_status_checks {
    strict   = true
    contexts = var.required_status_checks
  }

  depends_on = [github_repository.repo, github_repository_collaborators.repo_collaborators]
}

resource "github_repository_collaborators" "repo_collaborators" {
  repository = var.name

  # Always grant org-admins push (write) access to repository. This is necessary to support the
  # force_push_bypassers configuration (above).
  team {
    team_id    = "org-admins"
    permission = "push"
  }

  # Always allow organization members to triage issues
  team {
    team_id    = "all-members"
    permission = "triage"
  }

  # Generate team blocks from the value of the "teams" input variable.
  dynamic "team" {
    for_each = {
      for team in var.teams :
      team.team_id => team
    }
    content {
      team_id    = team.value.team_id
      permission = team.value.permission
    }
  }

  # Generate user blocks from the value of the "users" input variable.
  dynamic "user" {
    for_each = {
      for user in var.users :
      user.username => user
    }
    content {
      username   = user.value.username
      permission = user.value.permission
    }
  }

  depends_on = [github_repository.repo]
}

