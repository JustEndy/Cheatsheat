$file = Read-Host "irja be a fajl nevet"
if(-not (Test-Path $file)){
    "file nem letezik"
    exit
}
$even = "even.txt"
$odd = "odd.txt"

$i = 1
Get-Content $file | ForEach {
    if ($i % 2 -eq 0){
        Add-Content $even $_
    }
    else{
        Add-Content $odd $_
    }
    $i++
}
"kész | $(cat $odd) | $(cat $even)"