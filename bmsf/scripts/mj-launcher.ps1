# 📜 MJ-Class Entry Ritual
Clear-Host
Write-Host "📜 MJ-Class Entry Ritual Started"

# 🔍 Category Selection
$categories = @("Income", "Expense", "Donation", "Purchase", "Other")
Write-Host "`n🔍 Select Category:"
for ($i = 0; $i -lt $categories.Count; $i++) {
    Write-Host "$($i+1). $($categories[$i])"
}
$catChoice = Read-Host "Enter choice number"

if ($catChoice -lt 1 -or $catChoice -gt $categories.Count) {
    Write-Host "❌ Invalid category selection. Exiting..." -ForegroundColor Red
    exit
}

$category = $categories[$catChoice - 1]

# 📝 Description & Amount
$description = Read-Host "📝 Description"
$amount = Read-Host "💰 Amount"
if (-not ($amount -as [decimal])) {
    Write-Host "❌ Invalid amount. Please enter a numeric value." -ForegroundColor Red
    exit
}

$guardian = Read-Host "👤 Guardian Initials (optional)"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# 📦 Entry Format (YAML-friendly)
$entry = "$timestamp | $category | $description | $amount | $guardian"

# 📁 Archive Paths
$base = "E:\mj-ahmad\mj-entry\archive"
$day   = Join-Path $base "daily\$((Get-Date).ToString('yyyy-MM-dd'))"
$week  = Join-Path $base "weekly\week-$([math]::Floor((Get-Date).DayOfYear / 7))"
$month = Join-Path $base "monthly\$((Get-Date).ToString('yyyy-MM'))"
$year  = Join-Path $base "yearly\$((Get-Date).ToString('yyyy'))"

$folders = @($day, $week, $month, $year)

# 📂 Create folders if missing
foreach ($f in $folders) {
    if (!(Test-Path $f)) {
        New-Item -Path $f -ItemType Directory -Force | Out-Null
    }
}

# 🧾 Save entry in each archive
foreach ($f in $folders) {
    $file = Join-Path $f "entries.txt"
    Add-Content -Path $file -Value $entry
}

# 🧠 Audit Log (optional)
$logPath = Join-Path $base "audit-log.csv"
$logEntry = "$timestamp,$category,$amount,$guardian,$description"
if (!(Test-Path $logPath)) {
    "Timestamp,Category,Amount,Guardian,Description" | Out-File $logPath -Encoding UTF8
}
Add-Content -Path $logPath -Value $logEntry

Write-Host "`n✅ Entry saved in daily, weekly, monthly, yearly archives and audit log." -ForegroundColor Green
