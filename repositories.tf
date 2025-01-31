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

