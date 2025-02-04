# Populate variables with contents from local .csv files.

locals {
  # Parse team member files
  team_members_path = "team-members"
  team_members_files = {
    for file in fileset(local.team_members_path, "*.csv") :
    trimsuffix(file, ".csv") => csvdecode(file("${local.team_members_path}/${file}"))
  }

  # Create temp object that has team ID and CSV contents
  team_members_temp = flatten([
    for team, members in local.team_members_files : [
      {
        slug    = team
        members = members
      }
    ]
  ])

  # Create object for each team-user relationship
  team_members = flatten([
    for team in local.team_members_temp : [
      for member in team.members : {
        name     = "${team.slug}-${member.username}"
        team_id  = team.slug
        username = member.username
        role     = member.role
      }
    ]
  ])
}
