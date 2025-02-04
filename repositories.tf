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

module "repo_github_config" {
  source      = "./modules/common_repository"
  name        = "github-config"
  description = "Repository for managing innabox github organization"
}

module "repo_hypershift_demo" {
  source      = "./modules/common_repository"
  name        = "hypershift-demo"
  description = "Scripts used for the hypershift demo"
}

module "repo_dotgithub_private" {
  source      = "./modules/common_repository"
  visibility  = "private"
  name        = ".github-private"
  description = "Member-only README for innabox organization"
}

