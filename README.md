\# MJ-Class Entry Ritual



\## Structure

\- `scripts/mj-entry.ps1`: Main data entry script

\- `gui/mj-launcher.ps1`: GUI launcher

\- `mj-entry-launcher.bat`: One-click launcher

\- `archive/`: Daily, Weekly, Monthly, Yearly logs

\- `logs/`: Future export logs



\## Usage

1\. Run `mj-entry-launcher.bat`

2\. Select category, input description and amount

3\. Entry saved in all archive folders



\## Format

`timestamp | category | description | amount | guardian`



\## Future

\- CSV/Excel/JSON export

\- Git commit logs as public proof

\- Contributor onboarding via `onboard.ps1`





\## Export Tools



\### CSV Export

\- Script: `scripts/export-to-csv.ps1`

\- Converts all `entries.txt` files to structured `.csv`

\- Output: `logs/csv/\*.csv`



\### Excel Export

\- Script: `scripts/export-to-excel.ps1`

\- Converts `.csv` files to `.xlsx`

\- Output: `logs/xlsx/\*.xlsx`



\### Usage

1\. Run `export-to-csv.ps1`

2\. Then run `export-to-excel.ps1`

3\. All logs become spreadsheet-ready



\### Markdown Export

\- Script: `scripts/export-to-md.ps1`

\- Converts all `entries.txt` files to `.md` format

\- Output: `logs/markdown/\*.md`

\- Format: Markdown table with timestamp, category, description, amount, guardian



\### JSON Export

\- Script: `scripts/export-to-json.ps1`

\- Converts `entries.txt` to structured `.json`

\- Output: `logs/json/\*.json`



\### YAML Export

\- Script: `scripts/export-to-yaml.ps1`

\- Converts `entries.txt` to `.yaml` using `powershell-yaml` module

\- Output: `logs/yaml/\*.yaml`





