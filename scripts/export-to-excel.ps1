# MJ-Class Excel Converter
$csvPath = "E:\mj-ahmad\mj-entry\logs\csv"
$excelPath = "E:\mj-ahmad\mj-entry\logs\xlsx"
if (!(Test-Path $excelPath)) { New-Item -Path $excelPath -ItemType Directory | Out-Null }

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false

Get-ChildItem -Path $csvPath -Filter "*.csv" | ForEach-Object {
    $wb = $excel.Workbooks.Open($_.FullName)
    $outFile = Join-Path $excelPath ($_.BaseName + ".xlsx")
    $wb.SaveAs($outFile, 51)  # 51 = xlOpenXMLWorkbook (.xlsx)
    $wb.Close()
    Write-Host "📘 Converted: $outFile"
}

$excel.Quit()
