# MJ-Class Markdown Exporter
$archivePath = "E:\mj-ahmad\mj-entry\archive"
$exportPath = "E:\mj-ahmad\mj-entry\logs\markdown"
if (!(Test-Path $exportPath)) { New-Item -Path $exportPath -ItemType Directory | Out-Null }

# Loop through archive folders
Get-ChildItem -Path $archivePath -Recurse -Filter "entries.txt" | ForEach-Object {
    $inputFile = $_.FullName
    $lines = Get-Content $inputFile
    $mdLines = @()
    $mdLines += "# MJ-Class Entry Log"
    $mdLines += "📁 Source: `$($_.DirectoryName.Replace($archivePath, "").Trim('\'))`"
    $mdLines += "`n| Timestamp | Category | Description | Amount | Guardian |"
    $mdLines += "|-----------|----------|-------------|--------|----------|"

    foreach ($line in $lines) {
        $parts = $line -split "\s*\|\s*"
        $mdLines += "| $($parts[0]) | $($parts[1]) | $($parts[2]) | $($parts[3]) | $($parts[4]) |"
    }

    $relative = $_.DirectoryName.Replace($archivePath, "").Trim("\")
    $outFile = Join-Path $exportPath "$relative.md"
    $mdLines | Set-Content -Path $outFile
    Write-Host "📝 Exported: $outFile"
}
