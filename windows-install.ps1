$AppName = "Chippies"
$AppPath = "$env:LOCALAPPDATA\Chippies"
$ExePath = "$AppPath\Chippies.py"
$ShortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\$AppName.lnk"
$Hotkey = "0x20"  # Space key (use VK key codes)

# Ensure the target directory exists
if (!(Test-Path $AppPath)) {
    New-Item -ItemType Directory -Path $AppPath | Out-Null
}

# Move the app files
Copy-Item -Path ".\Chippies" -Destination "$ExePath" -Force
Write-Output "Chippies installed to $AppPath"

# Create a shortcut with a hotkey
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "python"
$Shortcut.Arguments = $ExePath
$Shortcut.WorkingDirectory = $AppPath
$Shortcut.Hotkey = "Ctrl+Alt+Space"  # Set the hotkey
$Shortcut.Save()

Write-Output "Shortcut created at $ShortcutPath"
Write-Output "Hotkey Ctrl+Alt+Space assigned."

# Optional: Pin to Start (Windows 10/11)
Start-Process "explorer.exe" -ArgumentList "/select,$ShortcutPath"
Write-Output "Manually pin the shortcut to Start if needed."

