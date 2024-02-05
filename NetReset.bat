@echo off

echo Granting full access permissions to Everyone for NSI registry key...
regini -a "HKLM\SYSTEM\CurrentControlSet\services\NSI" "%~dp0permissions.txt"

echo Disabling network adapters...
netsh interface set interface "Ethernet" admin=disable
netsh interface set interface "Wi-Fi" admin=disable

echo Flushing DNS cache...
ipconfig /flushdns

echo Resetting Winsock catalog...
netsh winsock reset

echo Resetting TCP/IP stack...
netsh int ip reset

echo Resetting network configuration...
netsh int reset all

echo Resetting firewall settings...
netsh advfirewall reset

echo Resetting Windows Firewall policies...
netsh advfirewall set allprofiles state on
netsh advfirewall reset

echo Resetting Internet Explorer settings...
start /wait inetcpl.cpl reset

echo Clearing temporary files...
del /F /Q %temp%\*

echo Clearing browser cache...
del /F /Q "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*"
del /F /Q "%LocalAppData%\Microsoft\Windows\INetCache\*"

echo Resetting proxy settings...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f

echo Resetting network adapters...
netsh int ip reset resetlog.txt
netsh winsock reset

echo Enabling network adapters...
netsh interface set interface "Ethernet" admin=enable
netsh interface set interface "Wi-Fi" admin=enable

echo Network reset complete.

pause
