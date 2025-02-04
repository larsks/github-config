# Innabox common repository configuration

## Variables

- `name` -- the name of the repository

- `visibility` -- [optional] either `public` or `private`

- `branch_protection` -- [optional] `true` (the default) to configure the default branch protection, `false` if you do not want branch protection configured.

- `labels` -- [optional] Issue label definitions for this repository if you do not want the standard set. This is a list of objects with `name`, `color`, and `description` attributes.

- `teams` -- [optional] A list of teams with access to the repository. The value is a list of objects with `team_id` and `permission` attributes.

- `users` -- [optional] A list of users with access to the repository. The value is a list of objects with `team_id` and `permission` attributes.

## Examples

### A very typical repository

```
module "repo_docs" {
  source      = "./modules/common_repository"
  name        = "docs"
  description = "General documentation for the AI in a Box project"
}
```

### A repository with a team collaborator

```
module "repo_docs" {
  source      = "./modules/common_repository"
  name        = "docs"
  description = "General documentation for the AI in a Box project"
  teams = [
    {
      team_id = "docs-workers"
      permission = "push"
    }
  ]
}
```
