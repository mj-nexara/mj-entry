# MJ-Class Daily Entry Script with Serial Number and File Lock Protection
# Author: MJ Ahmad
# Purpose: One CSV per day, continuous entry logging with donation and expenditure categories

# Setup paths
$base = "E:\mj-ahmad\mj-entry\bmsf\60-reports\daily"
$date = Get-Date -Format "yyyy-MM-dd"
$logFile = "$base\entry-log-$date.csv"

# Ensure folder exists
if (!(Test-Path $base)) {
    New-Item -Path $base -ItemType Directory -Force | Out-Null
}

# Check if file is locked
if (Test-Path $logFile) {
    try {
        $stream = [System.IO.File]::Open($logFile, 'Append', 'Write', 'None')
        $stream.Close()
    } catch {
        Write-Host "❌ Log file is currently open. Please close it before running the script." -ForegroundColor Red
        exit
    }
}

# Initialize log file if not exists
if (!(Test-Path $logFile)) {
    "Serial,Timestamp,Type,Category,Donor/Spent By,Voucher No,Amount,Method,Purpose/Reference,Approved By,Notes" | Out-File $logFile -Encoding UTF8
}

function AskOption($question, $options) {
    Write-Host "`n$question" -ForegroundColor Cyan
    for ($i = 0; $i -lt $options.Length; $i++) {
        Write-Host "$($i+1). $($options[$i])"
    }
    do {
        $choice = Read-Host "Enter option number"
    } while (-not ($choice -match '^[1-9][0-9]*$') -or [int]$choice -gt $options.Length)
    return $options[[int]$choice - 1]
}

function AskText($prompt) {
    return Read-Host $prompt
}

# Categories
$expenseCategories = @(
    "Mobile Bill", "Internet Bill", "Office Rent", "Utilities",
    "Transportation", "Food & Refreshments", "Staff Salary",
    "Stationery", "Printing", "Training", "Medical Support",
    "Emergency Relief", "Project (Local)", "Project (International)",
    "Legal Fees", "Bank Charges", "Software", "Volunteer Support",
    "Audit", "Miscellaneous"
)

$donationCategories = @(
    "General Fund", "Zakat", "Sadaqah", "Waqf", "Gaza Emergency",
    "Orphan Support", "Education", "Medical Aid", "Food Relief",
    "Ramadan", "Winter", "Disaster Response", "Mosque", "Water Project", "Other"
)

# Determine next serial number
$serial = 1
if (Test-Path $logFile) {
    $lines = Get-Content $logFile | Where-Object { $_ -match '^\d+,' }
    if ($lines.Count -gt 0) {
        $lastSerial = ($lines[-1] -split ",")[0]
        if ($lastSerial -match '^\d+$') {
            $serial = [int]$lastSerial + 1
        }
    }
}

# Entry type
$entryType = AskOption "What type of entry would you like to record?" @("Donation Received", "Expenditure")
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

if ($entryType -eq "Donation Received") {
    $category = AskOption "Select Donation Category" $donationCategories
    $donor = AskText "Donor Name"
    $amount = AskText "Amount"
    $method = AskText "Payment Method (Cash, Bank, Mobile, etc.)"
    $reference = AskText "Reference Number or Purpose"
    $notes = AskText "Additional Notes"
    $line = "$serial,$timestamp,Donation,$category,$donor,,$amount,$method,$reference,,${notes}"
}
else {
    $category = AskOption "Select Expense Category" $expenseCategories
    $spentBy = AskText "Who spent this amount?"
    $voucher = AskText "Voucher/Menu Number (if applicable)"
    $amount = AskText "Amount"
    $method = AskText "Payment Method (Cash, Bank, Mobile, etc.)"
    $purpose = AskText "Purpose of Expense"
    $approvedBy = AskText "Approved By"
    $notes = AskText "Additional Notes"
    $line = "$serial,$timestamp,Expenditure,$category,$spentBy,$voucher,$amount,$method,$purpose,$approvedBy,${notes}"
}

# Save entry
try {
    $stream = [System.IO.StreamWriter]::new($logFile, $true)
    $stream.WriteLine($line)
    $stream.Close()
    Write-Host "✅ Entry #$serial saved successfully to $logFile" -ForegroundColor Green
} catch {
    Write-Host "❌ Could not save entry. Please close the file if it's open." -ForegroundColor Red
}
