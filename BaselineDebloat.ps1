function Remove-UnnecessaryApps {
    $unnecessaryApps = @(
        # Microsoft Office
        "Microsoft.Office.Desktop",
        "Microsoft.Office.OneNote",

        # Communication and Collaboration
        "Microsoft.GetHelp",
        "Microsoft.MicrosoftOfficeHub",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.MicrosoftStickyNotes",
        "Microsoft.MicrosoftTo-Do",
        "Microsoft.Office.OneConnect",
        "Microsoft.People",
        "Microsoft.SkypeApp",
        "Microsoft.Teams",

        # Entertainment and Media
        "Microsoft.XboxApp",
        "Microsoft.Xbox.TCUI",
        "Microsoft.XboxIdentityProvider",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo",

        # Productivity and Utilities
        "Microsoft.Getstarted",
        "Microsoft.WindowsAlarms",
        "Microsoft.WindowsCalculator",
        "Microsoft.WindowsCamera",
        "Microsoft.WindowsMaps",
        "Microsoft.WindowsPhone",
        "Microsoft.WindowsSoundRecorder",

        # 3D and Gaming
        "Microsoft.Microsoft3DViewer",
        "Microsoft.MSPaint",
        "Microsoft.Print3D",

        # Other Apps
        "Microsoft.SkypeProvider",
        "Microsoft.WindowsFeedbackHub",

        # Dell bloatware (example)
        "DellInc.DellSupportAssistforPCs",
        "DellInc.DellSupportAssistAgent",

        # HP bloatware (example)
        "HewlettPackard.HPJumpStartBridge",
        "HewlettPackard.HPJumpStartLaunch",
        "HewlettPackard.HPJumpStartProvider",

        # Lenovo bloatware (example)
        "Lenovo.LenovoCompanion",
        "Lenovo.LenovoSettings",

        # Additional bloatware (customizable)
        "AdobeSystemsIncorporated.AdobePhotoshopExpress",
        "Facebook.Facebook",
        "King.com.CandyCrushSaga",
        "PandoraMediaInc.29680B314EFC2",
        "Twitter.Twitter",

        # Add more unnecessary app names as needed
    )

    foreach ($app in $unnecessaryApps) {
        $package = Get-AppxPackage -Name $app -ErrorAction SilentlyContinue
        if ($package -ne $null) {
            Write-Host "Removing app: $($package.Name)"
            Remove-AppxPackage -Package $package.PackageFullName -Confirm:$false
        } else {
            Write-Host "App not found: $app"
        }
    }
    
    Write-Host "App removal completed."
}

# Call the debloat function
Remove-UnnecessaryApps
