@echo off

echo Installing Steam...
start /wait "" "https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe" /silent

echo Installing Malwarebytes...
start /wait "" "https://downloads.malwarebytes.com/file/mb4_offline" /silent

echo Installing CCleaner...
start /wait "" "https://download.ccleaner.com/ccsetup.exe" /S

echo Installing Python x64...
start /wait "" "https://www.python.org/ftp/python/3.9.10/python-3.9.10-amd64.exe" /quiet InstallAllUsers=1 PrependPath=1

echo Installing Sysinternals Suite...
start /wait "" "https://download.sysinternals.com/files/SysinternalsSuite.zip"
powershell -Command "Expand-Archive -Path .\SysinternalsSuite.zip -DestinationPath .\SysinternalsSuite"

echo Updating Windows...
start ms-settings:windowsupdate-action

echo Updating Windows Defender...
start ms-settings:windowsdefender

echo Updating NVIDIA drivers...
start /wait "" "https://www.nvidia.com/Download/processDriver.aspx?psid=100&pfid=964&osid=57&lid=1&whql=1&lang=en-us"

echo Updating Realtek drivers...
start /wait "" "https://www.realtek.com/en/component/zoo/category/pc-audio-codecs-high-definition-audio-codecs-software"

echo Installing Notepad++...
start /wait "" "https://download.notepad-plus-plus.org/repository/7.x/7.9.5/npp.7.9.5.Installer.x64.exe"

echo Installing Microsoft Security Essentials...
start /wait "" "https://www.microsoft.com/en-us/download/confirmation.aspx?id=5201"

echo Installation completed.

pause
