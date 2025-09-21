# MJ-Class Daily Entry Setup for B.M. Sabab Foundation
# Author: MJ Ahmad (HR Head)
# Date: Auto-generated
# Purpose: Create daily CSV templates for all departments

$base = "E:\mj-ahmad\mj-entry\bmsf"
$date = Get-Date -Format "yyyy-MM-dd"

# Define categories and their paths
$categories = @{
    "Income"         = "$base\10-donation\summary\income-$date.csv"
    "Expense"        = "$base\20-expense\summary\expense-$date.csv"
    "Donation"       = "$base\10-donation\summary\donation-$date.csv"
    "Project-Local"  = "$base\30-projects\local\status-$date.csv"
    "Project-Intl"   = "$base\30-projects\international\status-$date.csv"
    "Attendance"     = "$base\40-HR\attendance\attendance-$date.csv"
    "Compliance"     = "$base\50-compliance\audit-trail\compliance-$date.csv"
}

# Define headers for each category
$headers = @{
    "Income"         = "Source,Amount,Method,Notes"
    "Expense"        = "Category,Amount,Purpose,Approved By,Notes"
    "Donation"       = "Donor,Amount,Channel,Reference,Notes"
    "Project-Local"  = "Project Name,Status,Lead,Beneficiaries,Notes"
    "Project-Intl"   = "Project Name,Status,Country,Partner,Notes"
    "Attendance"     = "Staff Name,Department,Present/Absent,Time In,Time Out"
    "Compliance"     = "Document Type,Submitted To,Status,Due Date,Notes"
}

# Create files with headers
foreach ($key in $categories.Keys) {
    $path = $categories[$key]
    $header = $headers[$key]
    if (-not (Test-Path $path)) {
        $header | Out-File $path -Encoding UTF8
        Write-Host "✅ Created $key entry file: $path" -ForegroundColor Green
    } else {
        Write-Host "⚠️ File already exists: $path" -ForegroundColor Yellow
    }
}

Write-Host "`n🎯 All daily entry files are ready for $date. You may now begin documentation rituals." -ForegroundColor Cyan
