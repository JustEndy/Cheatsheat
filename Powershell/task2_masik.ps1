param(
    [string]$folder="."
)

$files = Get-ChildItem $folder -Filter *.log
$errors = Select-String -Path $files -Pattern "ERROR" -SimpleMatch

#idk