# MJ-Class Entry Ritual
Clear-Host
Write-Host "📜 MJ-Class Entry Ritual Started"

# Category Selection
$categories = @("Income", "Expense", "Donation", "Purchase", "Other")
Write-Host "`n🔍 Select Category:"
for ($i = 0; $i -lt $categories.Count; $i++) {
    Write-Host "$($i+1). $($categories[$i])"
}
$catChoice = Read-Host "Enter choice number"
$category = $categories[$catChoice - 1]

# Description & Amount
$description = Read-Host "📝 Description"
$amount = Read-Host "💰 Amount"
$guardian = Read-Host "👤 Guardian Initials (optional)"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$entry = "$timestamp | $category | $description | $amount | $guardian"

# Archive Paths
$base = "E:\mj-ahmad\mj-entry\archive"
$day = Join-Path $base "daily\$((Get-Date).ToString('yyyy-MM-dd'))"
$week = Join-Path $base "weekly\week-$((Get-Date).DayOfYear / 7 -as [int])"
$month = Join-Path $base "monthly\$((Get-Date).ToString('yyyy-MM'))"
$year = Join-Path $base "yearly\$((Get-Date).ToString('yyyy'))"

$folders = @($day, $week, $month, $year)
foreach ($f in $folders) { if (!(Test-Path $f)) { New-Item -Path $f -ItemType Directory | Out-Null } }
foreach ($f in $folders) { Add-Content -Path "$f\entries.txt" -Value $entry }

Write-Host "`n✅ Entry saved in all archives."
