# This script should be modified to:
# 1. Set the IIS directory for the web application to: C:\inetpub\wwwroot\MyWebApp and create an IIS website
# 2. Create a file called configuration.xml in the C:\inetpub\wwwroot\MyWebApp directory. Have powershell Write-Host the contents of the file
# 3. Restart the IIS Service once configuration is complete
# This script handles parts of the configuration. You can modify it however you would like.

# Install the IIS Windows Feature
Install-WindowsFeature -Name Web-Server -IncludeManagementTools -Verbose
# Install ASP.net45
Install-WindowsFeature -Name Web-Asp-Net45

# Removes the IIS default site
Remove-IISSite -Name 'Default Web Site' -Confirm:$False

# Create a directory for our web application
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.4#example-4-create-a-directory-in-a-different-directory
#TODO: Write the powershell to create a directory at C:\inetpub\wwwroot\MyWebApp
New-Item -ItemType "directory" -Path C:\inetpub\wwwroot\MyWebApp
Write-Host "Web app directory created!"

# Configure the new website for IIS
#TODO: Implement me!
# https://learn.microsoft.com/en-us/powershell/module/webadministration/new-website?view=windowsserver2022-ps
New-Website -Name "MyWebApp" -Port 80 -PhysicalPath "C:\inetpub\wwwroot\MyWebApp"
Write-Host "Webroot configured for the created folder path!"

# Create a file called configuration.xml in the C:\inetpub\wwwroot\MyWebApp directory
# TODO: Implement me!
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-content?view=powershell-7.4
Set-Content -Path C:\inetpub\wwwroot\MyWebApp\configuration.xml -Value "<xml>I am XML configuration</xml>"
Write-Host "Content written to configuration.xml file"

# Restart the IIS Service
# TODO: Implement me!
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-service?view=powershell-7.4
Restart-Service -Name Web-Server
Write-Host "IIS server restarted, new content should be displayed! if not check your web-server config!"