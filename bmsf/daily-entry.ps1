# MJ-Class Daily Entry Script
$base = "E:\mj-ahmad\mj-entry\bmsf\60-reports\daily"
$date = Get-Date -Format "yyyy-MM-dd"

$incomeFile = "$base\income-$date.csv"
$expenseFile = "$base\expense-$date.csv"
$donationFile = "$base\donation-$date.csv"

# Create empty CSVs with headers
"Category,Amount,Source,Notes" | Out-File $incomeFile -Encoding UTF8
"Category,Amount,Purpose,Notes" | Out-File $expenseFile -Encoding UTF8
"Donor,Amount,Method,Notes" | Out-File $donationFile -Encoding UTF8

Write-Host "✅ Daily entry files created for $date" -ForegroundColor Green
