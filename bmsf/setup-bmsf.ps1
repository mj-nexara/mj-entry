# MJ-Class Setup Script for B.M. Sabab Foundation
# Author: MJ-Ahmad
# Purpose: Create inheritable, audit-ready folder structure and config files

$basePath = "E:\mj-ahmad\mj-entry\bmsf"

# Define folder structure
$folders = @(
    "00-config",
    "10-donation\incoming\online",
    "10-donation\incoming\offline",
    "10-donation\donor-profiles",
    "10-donation\proofs",
    "10-donation\summary",
    "20-expense\vouchers",
    "20-expense\invoices",
    "20-expense\audit-ready",
    "20-expense\summary",
    "30-projects\local",
    "30-projects\international",
    "30-projects\status-reports",
    "30-projects\impact",
    "30-projects\audit",
    "40-HR\staff-profiles",
    "40-HR\attendance",
    "40-HR\salary",
    "40-HR\contracts",
    "40-HR\performance",
    "50-compliance\govt-submissions",
    "50-compliance\international",
    "50-compliance\legal",
    "50-compliance\audit-trail",
    "60-reports\daily",
    "60-reports\weekly",
    "60-reports\monthly",
    "60-reports\annual"
)

# Create folders
foreach ($folder in $folders) {
    $fullPath = Join-Path $basePath $folder
    if (-not (Test-Path $fullPath)) {
        New-Item -Path $fullPath -ItemType Directory -Force | Out-Null
    }
}

# Create README anchor in root
$readmePath = Join-Path $basePath "README.yaml"
@"
title: "B.M. Sabab Foundation Documentation"
maintainer: "MJ-Ahmad"
last-updated: "$(Get-Date -Format 'yyyy-MM-dd')"
structure:
  - 00-config
  - 10-donation
  - 20-expense
  - 30-projects
  - 40-HR
  - 50-compliance
  - 60-reports
rituals:
  - daily-entry
  - weekly-summary
  - monthly-audit
  - annual-submission
"@ | Set-Content -Path $readmePath -Encoding UTF8

# Create sample config files
$configs = @{
    "org-profile.yaml" = @"
name: B.M. Sabab Foundation
president: B.M. Sabab
location: Dhaka, Bangladesh
mission: Empower communities through ethical service and global solidarity
vision: Transparent, inheritable systems for justice and dignity
"@

    "roles.yaml" = @"
HR-Head:
  name: MJ-Ahmad
  role: Documentation & Stewardship
  contact: mj.ahmad@bmsf.org
Finance-Lead:
  name: [Add Name]
  role: Expense & Audit
  contact: [Add Email]
"@

    "reporting-schedule.yaml" = @"
daily: donation-entry, expense-log, attendance
weekly: summary-generation, audit-check
monthly: donor-report, salary-disbursement, compliance-review
annual: impact-report, govt-submission, international-audit
"@
}

foreach ($file in $configs.Keys) {
    $path = Join-Path "$basePath\00-config" $file
    $configs[$file] | Set-Content -Path $path -Encoding UTF8
}

Write-Host "✅ B.M. Sabab Foundation documentary structure initialized successfully." -ForegroundColor Green
