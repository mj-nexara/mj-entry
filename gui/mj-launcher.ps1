Add-Type -AssemblyName Microsoft.VisualBasic
$run = [Microsoft.VisualBasic.Interaction]::MsgBox("Run MJ-Class Entry Ritual?", "YesNoCancel", "MJ Entry")
if ($run -eq "Yes") {
    powershell -ExecutionPolicy Bypass -File "E:\mj-ahmad\mj-entry\scripts\mj-entry.ps1"
}
