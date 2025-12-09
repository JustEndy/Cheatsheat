#2. feladat - fájlból az [ERROR] kezdetű sorok

param(
    #[Parameter(Mandatory = $true)]
    [string]$FilePath
)

if(-not (Test-Path $FilePath)){
    "Ilyen file nem letezik!"
   exit 1
}



Get-Content $FilePath | Where-Object { $_-match "^\[ERROR\]"}