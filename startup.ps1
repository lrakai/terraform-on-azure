$Region = "WestUS2"
Login-AzureRmAccount
New-AzureRmResourceGroup -Name terraform-lab -Location $Region
New-AzureRmResourceGroupDeployment -ResourceGroupName terraform-lab -Name lab-resources -TemplateFile .\infrastructure\arm-template.json