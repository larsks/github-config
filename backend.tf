# Define where terraform will store the shared state.
terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://stack.nerc.mghpcc.org:13808"
    }
    bucket                      = "tfstate"
    key                         = "innabox.tfstate"
    region                      = "main"
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}
