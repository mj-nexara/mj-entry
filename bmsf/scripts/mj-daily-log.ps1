# MJ-Class Interactive Daily Logger
# Author: MJ Ahmad (HR Head)
# Date: Auto-generated
# Purpose: Collect daily entries across categories and generate final log

$base = "E:\mj-ahmad\mj-entry\bmsf\60-reports\daily"
$date = Get-Date -Format "yyyy-MM-dd"
$logFile = "$base\final-log-$date.csv"

# Initialize log file with header
"Category,Field1,Field2,Field3,Field4,Notes" | Out-File $logFile -Encoding UTF8

function AskAndLog($category, $fields) {
    Write-Host "`n🟦 $category Entry" -ForegroundColor Cyan
    $answers = @()
    foreach ($field in $fields) {
        $input = Read-Host "$field"
        $answers += $input
    }
    $line = "$category," + ($answers -join ",")
    Add-Content $logFile $line
    Write-Host "✅ $category entry saved." -ForegroundColor Green
}

# Income
AskAndLog "Income" @("Source", "Amount", "Method", "Notes")

# Expense
AskAndLog "Expense" @("Category", "Amount", "Purpose", "Approved By", "Notes")

# Donation
AskAndLog "Donation" @("Donor", "Amount", "Channel", "Reference", "Notes")

# Project (Local)
AskAndLog "Project-Local" @("Project Name", "Status", "Lead", "Beneficiaries", "Notes")

# Project (International)
AskAndLog "Project-Intl" @("Project Name", "Status", "Country", "Partner", "Notes")

# Attendance
AskAndLog "Attendance" @("Staff Name", "Department", "Present/Absent", "Time In", "Time Out")

# Compliance
AskAndLog "Compliance" @("Document Type", "Submitted To", "Status", "Due Date", "Notes")

Write-Host "`n🎯 Final log created: $logFile" -ForegroundColor Yellow
