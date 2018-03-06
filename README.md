# terraform-on-azure

Demonstrate how to use modules shared on the public Terraform Registry, and create your own. The goal is to use modules to deploy a web server in Azure.

![Environment on completion](https://user-images.githubusercontent.com/3911650/37015433-52557eb0-20c4-11e8-9d55-b078633e4414.png)

## Getting Started

An Azure RM template is included in `infrastructure/` to create the environment:

<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Flrakai%2Fterraform-on-azure%2Fmaster%2Finfrastructure%2Farm-template.json">
    <img src="https://camo.githubusercontent.com/536ab4f9bc823c2e0ce72fb610aafda57d8c6c12/687474703a2f2f61726d76697a2e696f2f76697375616c697a65627574746f6e2e706e67" data-canonical-src="http://armviz.io/visualizebutton.png" style="max-width:100%;">
</a> 

Using Azure PowerShell, do the following to provision the resources:

```ps1
.\startup.ps1
```

Alternatively, you can perform a one-click deploy with the following button:

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flrakai%2Fterraform-on-azure%2Fmaster%2Finfrastructure%2Farm-template.json">
    <img src="https://camo.githubusercontent.com/9285dd3998997a0835869065bb15e5d500475034/687474703a2f2f617a7572656465706c6f792e6e65742f6465706c6f79627574746f6e2e706e67" data-canonical-src="http://azuredeploy.net/deploybutton.png" style="max-width:100%;">
</a>

## Following Along

1. Create a Bash Azure Cloud Shell in the cloudshell storage account that is created by the template. Terraform is installed in the cloud shell by default and is automatically authenticated.
1. Copies the files in the `src/` directory to the Cloud Shell file share.
1. Change into the `clouddrive/` directory in the Cloud Shell to see the copied files.
1. Initialize the working directory with `terraform init`

    1. Cloud Shell doesn't support soft links. As a workaround you can create copies of the modules in the `.terraform/modules` directory using the directory names given in the error messages
    
1. Apply the configuration changes with `terraform apply` to have all the resources created and the VM provisioned.

## Tearing Down

When finished, remove the Azure resources with:

```ps1
.\teardown.ps1
```
