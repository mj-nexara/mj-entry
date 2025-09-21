# MJ-Class JSON Exporter
$archivePath = "E:\mj-ahmad\mj-entry\archive"
$exportPath = "E:\mj-ahmad\mj-entry\logs\json"
if (!(Test-Path $exportPath)) { New-Item -Path $exportPath -ItemType Directory | Out-Null }

Get-ChildItem -Path $archivePath -Recurse -Filter "entries.txt" | ForEach-Object {
    $inputFile = $_.FullName
    $lines = Get-Content $inputFile
    $jsonData = @()

    foreach ($line in $lines) {
        $parts = $line -split "\s*\|\s*"
        $jsonData += [PSCustomObject]@{
            timestamp   = $parts[0]
            category    = $parts[1]
            description = $parts[2]
            amount      = $parts[3]
            guardian    = $parts[4]
        }
    }

    $relative = $_.DirectoryName.Replace($archivePath, "").Trim("\")
    $outFile = Join-Path $exportPath "$relative.json"
    $jsonData | ConvertTo-Json -Depth 3 | Set-Content -Path $outFile
    Write-Host "🧾 Exported: $outFile"
}
