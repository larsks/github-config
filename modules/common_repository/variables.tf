variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = ""
}

variable "visibility" {
  type    = string
  default = "public"
  validation {
    error_message = "unknown visiblity: must be public or private"
    condition     = contains(["public", "private"], var.visibility)
  }
}

variable "branch_protection" {
  type    = bool
  default = true
}

variable "labels" {
  type = list(object({
    name        = string
    color       = string
    description = string
  }))
  default = null
}

variable "teams" {
  description = "Teams with access to this repository"
  type = list(object({
    team_id    = string
    permission = string
  }))
  default = []
  validation {
    error_message = "unknown permission: permission must be one of pull, push, maintain, triage, or admin"
    condition = alltrue([
      for v in var.teams : contains(["pull", "push", "maintain", "triage", "admin"], v.permission)
    ])
  }
}

variable "users" {
  description = "Users with access to this repository"
  type = list(object({
    username   = string
    permission = string
  }))
  default = []
  validation {
    error_message = "unknown permission: permission must be one of pull, push, maintain, triage, or admin"
    condition = alltrue([
      for v in var.users : contains(["pull", "push", "maintain", "triage", "admin"], v.permission)
    ])
  }
}
