# Import the module for managing Windows features
Import-Module ServerManager

# Uninstall any third-party software
Get-WmiObject -Class Win32_Product | ForEach-Object {
    $_.Uninstall()
}

# Reset Windows features to their default state
Get-WindowsFeature | Where-Object {$_.Installed -and $_.InstallState -eq 'Installed'} | ForEach-Object {
    Write-Host "Disabling feature: $($_.Name)"
    Disable-WindowsOptionalFeature -FeatureName $_.Name -Online
}

# Reset Windows settings to their default values
$settingsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3"
Remove-Item -Path $settingsPath -Recurse -Force

# Remove any customizations made to the Windows registry
$registryPaths = @(
    "HKCU:\Software",
    "HKCU:\Control Panel",
    "HKCU:\Desktop",
    "HKCU:\AppEvents",
    "HKCU:\Environment"
)

foreach ($path in $registryPaths) {
    Write-Host "Removing registry path: $path"
    Remove-Item -Path $path -Recurse -Force
}

# Reset Windows wallpaper to the default
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value "C:\Windows\Web\Wallpaper\Windows\img0.jpg"

# Clear temporary files and folders
Write-Host "Clearing temporary files and folders"
Remove-Item -Path "C:\Windows\Temp\*" -Force -Recurse

# Reset network settings
Write-Host "Resetting network settings"
netsh int ip reset
netsh winsock reset

# Restart the computer for changes to take effect
Write-Host "Restarting computer..."
Restart-Computer -Force
