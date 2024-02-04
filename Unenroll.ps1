# Disable Enterprise and MDM features
Write-Host "Disabling Enterprise and MDM features..."

# Disable MDM enrollment
Write-Host "Disabling MDM enrollment..."
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM"
Set-ItemProperty -Path $RegistryPath -Name "AutoEnrollment" -Value 0 -Force

# Disable MDM user scope
Write-Host "Disabling MDM user scope..."
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM"
Set-ItemProperty -Path $RegistryPath -Name "UserScope" -Value 0 -Force

# Disable MDM device scope
Write-Host "Disabling MDM device scope..."
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM"
Set-ItemProperty -Path $RegistryPath -Name "DeviceScope" -Value 0 -Force

# Disable MDM enrollment URL
Write-Host "Disabling MDM enrollment URL..."
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM"
Set-ItemProperty -Path $RegistryPath -Name "EnrollmentServerUrl" -Value "" -Force

# Disable Enterprise enrollment
Write-Host "Disabling Enterprise enrollment..."
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\CloudDomainJoin\TenantDnsName"
Set-ItemProperty -Path $RegistryPath -Name "CloudDomainJoinConfigured" -Value 0 -Force

Write-Host "Enterprise and MDM features have been disabled."
