# Clear Temp Files
Remove-Item -Path "$env:TEMP\*" -Force -Recurse

# Clear Cookies
$cookiesPath = "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCookies"
Remove-Item -Path $cookiesPath -Force -Recurse

# Clear Browsing History
$historyPath = "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCache\Low\IE"
Remove-Item -Path $historyPath -Force -Recurse

# Clear Recycle Bin
Clear-RecycleBin -Force

# Clear Prefetch Files
$prefetchPath = "$env:SYSTEMROOT\Prefetch"
Remove-Item -Path $prefetchPath\* -Force

# Clear DNS Cache
ipconfig /flushdns

# Clear Thumbnail Cache
$thumbCachePath = "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer"
Remove-Item -Path $thumbCachePath\thumbcache_* -Force

# Clear Temporary Internet Files
$internetCachePath = "$env:LOCALAPPDATA\Microsoft\Windows\INetCache"
Remove-Item -Path $internetCachePath -Force -Recurse

# Clear Java Cache (if installed)
$javaCachePath = "$env:LOCALAPPDATA\Sun\Java\Deployment\cache"
if (Test-Path $javaCachePath) {
    Remove-Item -Path $javaCachePath -Force -Recurse
}

# Clear Adobe Flash Cache (if installed)
$flashCachePath = "$env:LOCALAPPDATA\Adobe\Flash Player\NativeCache"
if (Test-Path $flashCachePath) {
    Remove-Item -Path $flashCachePath -Force -Recurse
}

# Clear Windows Temporary Files
Start-Process -FilePath Cleanmgr.exe -ArgumentList "/sagerun:1" -Wait

# Clear Windows Search Index
$indexer = New-Object -ComObject "Microsoft.Search.Interop.CSearchManager"
$crawlScopeManager = $indexer.GetCatalog("SystemIndex").CrawlScopeManager
$crawlScopeManager.RemoveAllURLs()
$crawlScopeManager.Commit()

# Clear Windows Prefetch Folder
$prefetchPath = "$env:SYSTEMROOT\Prefetch"
Remove-Item -Path $prefetchPath\* -Force

# Clear Windows Run History
Clear-History -Count -1

# Clear Windows Update Cache
Stop-Service -Name wuauserv -Force
Remove-Item -Path "$env:SYSTEMROOT\SoftwareDistribution\Download\*" -Force -Recurse
Start-Service -Name wuauserv

# Disable Windows Telemetry
$telemetryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
if (-not (Test-Path $telemetryPath)) {
    New-Item -Path $telemetryPath -Force
}
Set-ItemProperty -Path $telemetryPath -Name AllowTelemetry -Value 0 -Type DWord

Write-Host "Comprehensive cleanup completed successfully."
