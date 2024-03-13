# Packer and GCP

This is an example repo for building a Windows image using Packer ang GCP. You don't have to actually run these commands if you don't have the ability to create your own Google Cloud project, but the instructions are here if you would like to try to build this.

Helpful documentation: https://developer.hashicorp.com/packer/integrations/hashicorp/googlecompute/latest/components/builder/googlecompute

## Your Job

Read through the [`customization.ps1`](./customization.ps1) file for instructions. There are at the top of the file, commented out. Follow the instructions and save your changes. You can try building in GCP with packer if you would like, but it's not a requirement.

## Prerequisit Installs

1. [Google Cloud CLI installed](https://cloud.google.com/sdk/docs/install)
2. [Hashicorp Packer installed](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli)
3. Some sort of code editor. VSCode with the following extensions is probably the easiest to set up:
   1. [Hashicorp HCL Language Support](https://marketplace.visualstudio.com/items?itemName=HashiCorp.HCL)

## Google Cloud Project

You will need access to a google cloud project. If you have never used google cloud at all, there is a [free trial for 90 days](https://cloud.google.com/free/docs/free-cloud-features#free-trial). If you have already used your free trial, then you'll have to set up your own cloud project, but this exercise should not cost more than a few dollars if you spin down your work once you're done.

You will need to enable the following APIs for your project:

```shell
gcloud services enable sourcerepo.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable servicemanagement.googleapis.com
gcloud services enable storage-api.googleapis.com

```

## Run Packer

To build a packer image in this repo, run: `packer build .` in the same directory as this repo. You will need to be authenticated with the google cloud SDK and your gcloud cli must be logged in: `gcloud auth login`.
