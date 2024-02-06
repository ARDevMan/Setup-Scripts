# Run PowerShell as an administrator
# Enable Tamper Protection
Set-MpPreference -EnableTamperProtection $true

# Enable real-time monitoring
Set-MpPreference -DisableRealtimeMonitoring $false

# Enable cloud-delivered protection
Set-MpPreference -MAPSReporting Enabled
Set-MpPreference -SubmitSamplesConsent AlwaysPrompt

# Enable behavior monitoring
Set-MpPreference -EnableBehaviorMonitoring $true

# Enable network protection
Set-MpPreference -EnableNetworkProtection $true

# Enable controlled folder access
Set-MpPreference -EnableControlledFolderAccess Enable

# Enable cloud-based protection
Set-MpPreference -CloudPUServerProxyProxyType HttpProxy
Set-MpPreference -CloudPUServerProxyServerAddress "proxy-server-address"
Set-MpPreference -CloudPUServerProxyServerPort "proxy-server-port"

# Enable automatic sample submission
Set-MpPreference -MAPSReporting Advanced

# Enable script scanning
Set-MpPreference -EnableScriptScanning $true

# Configure real-time scan schedule
Set-MpPreference -ScanAvgCPULoadFactor 50
Set-MpPreference -ScanAvgCPULoadFactorMax 50
Set-MpPreference -ScanAvgCPULoadFactorMin 50
Set-MpPreference -ScanAvgCPULoadFactorPerCPU 50
Set-MpPreference -ScanPriority 4
Set-MpPreference -ScanScheduleDay 0
Set-MpPreference -ScanScheduleQuickScanTime 600
Set-MpPreference -ScanType 2

# Enable sample sharing
Set-MpPreference -SubmitSamplesConsent 2

# Enable cloud-based blocking level
Set-MpPreference -CloudBlockLevel 2

# Configure cloud protection level
Set-MpPreference -CloudProtectionLevel 2

# Restart the Windows Security service
Restart-Service -Name "SecurityHealthService"
