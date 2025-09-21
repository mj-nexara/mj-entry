# MJ-Class CSV Exporter
$archivePath = "E:\mj-ahmad\mj-entry\archive"
$exportPath = "E:\mj-ahmad\mj-entry\logs\csv"
if (!(Test-Path $exportPath)) { New-Item -Path $exportPath -ItemType Directory | Out-Null }

# Loop through archive folders
Get-ChildItem -Path $archivePath -Recurse -Filter "entries.txt" | ForEach-Object {
    $inputFile = $_.FullName
    $lines = Get-Content $inputFile
    $csvData = @()

    foreach ($line in $lines) {
        $parts = $line -split "\s*\|\s*"
        $csvData += [PSCustomObject]@{
            Timestamp   = $parts[0]
            Category    = $parts[1]
            Description = $parts[2]
            Amount      = $parts[3]
            Guardian    = $parts[4]
        }
    }

    $relative = $_.DirectoryName.Replace($archivePath, "").Trim("\")
    $outFile = Join-Path $exportPath "$relative.csv"
    $csvData | Export-Csv -Path $outFile -NoTypeInformation
    Write-Host "✅ Exported: $outFile"
}
