# Disable unnecessary services
$servicesToDisable = @(
    "Telnet",
    "FTP",
    "Remote Registry",
    "NetMeeting Remote Desktop Sharing",
    "Simple Network Management Protocol (SNMP)",
    "Server",
    "Print Spooler"
)

foreach ($service in $servicesToDisable) {
    if (Get-Service -Name $service -ErrorAction SilentlyContinue) {
        Stop-Service -Name $service -Force
        Set-Service -Name $service -StartupType Disabled
    }
}

# Enable Windows Firewall and block unnecessary ports
$firewallProfile = Get-NetFirewallProfile | Where-Object { $_.Enabled -eq $false }

if ($firewallProfile) {
    Enable-NetFirewallProfile -Profile $firewallProfile.Profile
}

$portsToBlock = @(135, 137, 138, 139, 445)

foreach ($port in $portsToBlock) {
    if (-not (Get-NetFirewallRule -DisplayName "Block Port $port" -ErrorAction SilentlyContinue)) {
        New-NetFirewallRule -DisplayName "Block Port $port" -Enabled True -Direction Inbound -Action Block -Protocol TCP -LocalPort $port
        New-NetFirewallRule -DisplayName "Block Port $port" -Enabled True -Direction Inbound -Action Block -Protocol UDP -LocalPort $port
    }
}

# Enable Windows Defender and update definitions
if ((Get-MpPreference).DisableRealtimeMonitoring -eq 1) {
    Set-MpPreference -DisableRealtimeMonitoring 0
}

Update-MpSignature -UpdateSource "MicrosoftUpdateServer"

# Disable PowerShell remoting
if (Test-WSMan -ErrorAction SilentlyContinue) {
    Disable-PSRemoting -Force
}

# Enable Windows Defender Exploit Protection
$mitigationOptions = @{
    DEP   = 'Enabled'
    SEHOP = 'Enabled'
    ASLR  = 'Enabled'
    CFG   = 'Enabled'
}

Set-ProcessMitigation -System -ProcessMitigationOptions $mitigationOptions

# Configure Windows Defender Controlled Folder Access
$controlledFolderAccess = Get-MpPreference | Select-Object -ExpandProperty EnableControlledFolderAccess

if ($controlledFolderAccess -ne 'Enabled') {
    Set-MpPreference -EnableControlledFolderAccess Enabled
    $protectedFolders = @(
        "C:\Program Files",
        "C:\Program Files (x86)",
        "C:\Windows",
        "C:\Users"
    )
    Set-MpPreference -ControlledFolderAccessProtectedFolders $protectedFolders
}

# Enable Windows Event Logging
$eventLogs = @("Security", "System", "Application")

foreach ($log in $eventLogs) {
    $logStatus = wevtutil gl $log | Select-String -Pattern "loggingEnabled:true"

    if (-not $logStatus) {
        wevtutil sl $log /e:true /q
    }
}

# Disable unnecessary Windows features
$featuresToDisable = @(
    "Internet Explorer 11",
    "Windows Media Player",
    "Telnet Client",
    "Print and Document Services"
)

foreach ($feature in $featuresToDisable) {
    if ((Get-WindowsOptionalFeature -FeatureName $feature -Online -ErrorAction SilentlyContinue).State -eq "Enabled") {
        Disable-WindowsOptionalFeature -FeatureName $feature -Online -NoRestart
    }
}

# Disable SMBv1 protocol
$SMBv1Enabled = Get-SmbServerConfiguration | Select-Object -ExpandProperty EnableSMB1Protocol

if ($SMBv1Enabled) {
    Set-SmbServerConfiguration -EnableSMB1Protocol $false
    Set-SmbClientConfiguration -EnableSMB1Protocol $false
}

# Enable Windows Defender Application Guard (if supported)
$wdagFeature = Get-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -Online

if ($wdagFeature.State -ne "Enabled") {
    Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -Online -NoRestart
    Restart-Computer -Force
}

# Enable automatic Windows updates
$AutoUpdateOptions = Get-WindowsUpdateSetting | Select-Object -ExpandProperty AutoUpdateOptions

if ($AutoUpdateOptions -ne "MinorInstallationsAllowed") {
    Set-WindowsUpdateSetting -AutoUpdateOptions MinorInstallationsAllowed
}

Write-Host "Windows hardening script execution complete."
