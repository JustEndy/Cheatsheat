param(
    [string]$file1,
    [string]$file2

)
<#$file1 = Read-Host "irja be a sablon fajl nevet"
if(-not (Test-Path $file1)){
    "file nem letezik"
    exit
}
$file2 = Read-Host "irja be az adatbazis fajl nevet"
if(-not (Test-Path $file2)){
    "file nem letezik"
    exit
}#>
$sablon=Get-Content $file1 -Raw
$adatbazis=Get-Content $file2

foreach ($sor in $adatbazis) {
    $egysor=$sor -split ","
    $nev=$egysor[0]
    $cim=$egysor[1]
    $ido=$egysor[2]

    $korlevel=$sablon

    $korlevel= $korlevel -replace "<nev>", $nev
    $korlevel= $korlevel -replace "<idopont>", $ido
    $korlevel= $korlevel -replace "<cim>", $cim

    "~~~~~"
    "$korlevel"  

}
"~~~~~"