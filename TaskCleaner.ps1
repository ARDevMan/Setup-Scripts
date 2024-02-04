# Get all scheduled tasks
$scheduledTasks = Get-ScheduledTask

# Check if the current user has administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as an administrator."
    Exit
}

# Delete non-Microsoft scheduled tasks
foreach ($task in $scheduledTasks) {
    if ($task.Principal.UserId -notlike "*Microsoft*" -and $task.Principal.UserId -notlike "*SYSTEM*") {
        Write-Host "Deleting task: $($task.TaskName)"
        Unregister-ScheduledTask -TaskName $task.TaskName -Confirm:$false
    }
}

# Disable non-Microsoft scheduled tasks
$taskFolder = Get-ScheduledTask | Where-Object { $_.Principal.UserId -notlike "*Microsoft*" -and $_.Principal.UserId -notlike "*SYSTEM*" } | Select-Object -ExpandProperty TaskPath -Unique
$nonMicrosoftTasks = Get-ScheduledTask | Where-Object { $_.Principal.UserId -notlike "*Microsoft*" -and $_.Principal.UserId -notlike "*SYSTEM*" }
$nonMicrosoftTasks | ForEach-Object {
    $taskName = $_.TaskName
    $taskPath = Join-Path -Path $taskFolder -ChildPath $taskName
    Write-Host "Disabling task: $taskPath"
    Disable-ScheduledTask -TaskPath $taskFolder -TaskName $taskName
}

Write-Host "Scheduled tasks cleanup completed successfully."
