$AppName = "Chippies"
$AppPath = "$env:LOCALAPPDATA\Chippies"
$ExePath = "$AppPath\Chippies.py"
$ShortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\$AppName.lnk"
$Hotkey = "0x20"  # Space key (use VK key codes)

if (!(Test-Path $AppPath)) {
    New-Item -ItemType Directory -Path $AppPath | Out-Null
}

Copy-Item -Path ".\Chippies" -Destination "$ExePath" -Force
Write-Output "Chippies installed to $AppPath"

$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "pythonw"
$Shortcut.Arguments = $ExePath
$Shortcut.WorkingDirectory = $AppPath
$Shortcut.Hotkey = "Ctrl+Alt+Space"
$Shortcut.Save()

Write-Output "Shortcut created at $ShortcutPath"
Write-Output "Hotkey Ctrl+Alt+Space assigned."

Start-Process "explorer.exe" -ArgumentList "/select,$ShortcutPath"
Write-Output "Pinned the shortcut to Start."

