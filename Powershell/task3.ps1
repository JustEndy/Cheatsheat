#3. feladat - Azok a txt fájlok, amik régebbiek 30 napnál, kerüljenek törlésre
#$current=Get-Date
#$harminc=$current.Subtract(30)
$fullPath = "C:\Users\iyyd3j\Desktop\szamrend"

Get-ChildItem -Path $fullPath -Filter "." | ForEach-Object {
    $lastwirte=$_.LastWriteTime
    $timespan = NewTimeSpan -Days 10
    "File: $_"
    if (((Get-Date) - $lastwirte) -gt $timespan) {
        "${$_.FullName}"

    }
}