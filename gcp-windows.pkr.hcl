packer {
  required_plugins {  
    googlecompute = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/googlecompute"
    }
  }
}

variable "project_id" {
  type = string
  description = "The Google project ID where you want to build the packer image."
}

variable "zone" {
  type = string
  default = "us-west1-b"
}

// variable "builder_sa" {
//   type = string
// }

/*
1. Use compute engine service account for dev projects, create a separate account for prod with less access as best practice
2. pull the temp password from GCP secrets manager via data source instead of hardcoding
3. Assign labels for organization and use spot for cheap build or low priority builds
*/

source "googlecompute" "davita_windows" {
  project_id                  = var.project_id
  source_image_family         = "windows-2022"
  zone                        = var.zone
  image_description           = "Created with HashiCorp Packer for DaVita"
  image_storage_locations     = ["us-west1"]
  communicator                = "winrm"
  winrm_password              = "p@ckerbuilt8*"
  winrm_username              = "builtby_packer"
  winrm_insecure              = true
  winrm_use_ssl               = true
  machine_type                = "n1-standard-2"
  disk_size                   = 50
  tags                        = ["packer-winrm"]
  metadata = {
    windows-startup-script-cmd = "winrm quickconfig -quiet & net user builtby_packer p@ckerbuilt8* /add & net localgroup administrators builtby_packer /add & winrm set winrm/config/service/auth @{Basic=\"true\"}"
  }
}

build {
  sources = ["sources.googlecompute.davita_windows"]

  provisioner "powershell" {
    elevated_user = "builtby_packer"
    elevated_password = "p@ckerbuilt8*"
    scripts = [
      "customization.ps1"
    ]
  }
}