$AppPath = "$env:LOCALAPPDATA\Chippies"
$Hotkey = "Ctrl+Alt+Space"

if (!(Test-Path $AppPath)) {
    New-Item -ItemType Directory -Path $AppPath | Out-Null
}

Copy-Item -Path ".\Chippies" -Destination "$AppPath\Chippies.py" -Force
Write-Output "Chippies installed to $AppPath"

$ShortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Chippies.lnk"

$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "pythonw"
$Shortcut.Arguments = "$AppPath\Chippies.py"
$Shortcut.WorkingDirectory = $AppPath
$Shortcut.Hotkey = $Hotkey
$Shortcut.Save()

Write-Output "Creating commandline executable."
"CreateObject(`"Wscript.Shell`").Run `"pythonw %LOCALAPPDATA%/Chippies/Chippies.py`", 0, True" | Out-File -FilePath "$AppPath\Chippies.vbs"

Write-Output "Shortcut created at $ShortcutPath and hotkey set."
Write-Output "If you want to be able to run Chippies from commandline, make sure to put '$env:LOCALAPPDATA\Chippies' in your PATH."
