module "repo_issues" {
  source            = "./modules/common_repository"
  name              = "issues"
  visibility        = "private"
  description       = "Issues related to AI in a Box project"
  branch_protection = false
}

module "repo_docs" {
  source      = "./modules/common_repository"
  name        = "docs"
  description = "General documentation for the AI in a Box project"
}

module "repo_dotgithub" {
  source      = "./modules/common_repository"
  name        = ".github"
  description = "Profile README for innabox organization"
}
