# Create teams from the contents of "teams.csv"
resource "github_team" "all" {
  for_each = {
    for team in csvdecode(file("teams.csv")) :
    team.name => team
  }

  name        = each.value.name
  description = each.value.description
  privacy     = each.value.privacy
}

# Populate team members based on the csv files in the team-members directory.
resource "github_team_membership" "members" {
  for_each = { for tm in local.team_members : tm.name => tm }

  team_id  = each.value.team_id
  username = each.value.username
  role     = each.value.role
}

## This creates an "all-members" team containing all organization members. I thought it might
## be useful for repository permissions, but I'm not sure. Leaving it here for now as an example.
##
#resource "github_team" "all-members" {
#  name        = "all-members"
#  description = "All organization members"
#  privacy     = "closed"
#
#}
#
#resource "github_team_membership" "all-members" {
#  for_each = {
#    for member in csvdecode(file("members.csv")) :
#    member.username => member
#  }
#
#  team_id  = "all-members"
#  role     = "member"
#  username = each.value.username
#}
