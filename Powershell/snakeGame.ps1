  
$Signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
    public static extern short GetAsyncKeyState(int virtualKeyCode); 
'@
Add-Type -MemberDefinition $Signature -Name Keyboard -Namespace PsOneApi

enum Tile {
    Error
    Grass1
    Grass2
    Grass3
    Snake
    Coin
}

$gameover = $false
$score = 0
$Length = 1
$Height = 10
$Width = 30
$randomX = Get-Random -Minimum 0 -Maximum $Width
$randomY = Get-Random -Minimum 0 -Maximum $Height
$map = New-Object -TypeName 'Tile[,]' -ArgumentList $Width,$Height
$SnakeBody = New-Object System.Collections.ArrayList
[void]$SnakeBody.Add([PSCustomObject]@{ X = [math]::Floor($Width/2); Y = [math]::Floor($Height/2) })

    for($y = 0; $y -lt $Height; $y++) {
        for($x = 0; $x -lt $Width; $x++) {
                $randomGrass = Get-Random -Minimum 1 -Maximum 100
                if ($randomGrass -lt 20) {
                    $map[$x,$y] = [Tile]::Grass1
                } elseif ($randomGrass -lt 50) {
                    $map[$x,$y] = [Tile]::Grass2
                } else {
                    $map[$x,$y] = [Tile]::Grass3
                }
        }
    }

do
{
  $APress = [bool]([PsOneApi.Keyboard]::GetAsyncKeyState([Byte][Char]'A') -eq -32767)  
  $DPress = [bool]([PsOneApi.Keyboard]::GetAsyncKeyState([Byte][Char]'D') -eq -32767)
  $WPress = [bool]([PsOneApi.Keyboard]::GetAsyncKeyState([Byte][Char]'W') -eq -32767)
  $SPress = [bool]([PsOneApi.Keyboard]::GetAsyncKeyState([Byte][Char]'S') -eq -32767)

  if($SnakeBody[0].X -eq $randomX -and $SnakeBody[0].Y -eq $randomY) { 
    $score++
    $randomX = Get-Random -Minimum 0 -Maximum $Width
    $randomY = Get-Random -Minimum 0 -Maximum $Height
    [void]$SnakeBody.Add([PSCustomObject]@{X=$SnakeBody[0].X;Y=$SnakeBody[0].Y})
  }

  #[Coord]@{x=5;y=5}

  if ($APress -or $DPress -or $WPress -or $SPress) {
    Clear-Host
    for($i = $SnakeBody.Count-1;$i -gt 0;$i--)
    {
        $SnakeBody[$i].X = $SnakeBody[$i-1].X
        $SnakeBody[$i].Y = $SnakeBody[$i-1].Y
    }

    if ($APress) {$SnakeBody[0].X--}
    if ($DPress) {$SnakeBody[0].X++}
    if ($WPress) {$SnakeBody[0].Y--}
    if ($SPress) {$SnakeBody[0].Y++}

    if($SnakeBody[0].X -ge $Width) {
        $SnakeBody[0].X = 0
    }
    if($SnakeBody[0].X -lt 0) {
        $SnakeBody[0].X = $Width
    }
    if($SnakeBody[0].Y -ge $Height) {
        $SnakeBody[0].Y = 0
    }
    if($SnakeBody[0].Y -lt 0) {
        $SnakeBody[0].Y = $Height
    }

    for($i = 1; $i -lt $SnakeBody.Count; $i++) {
        if($SnakeBody[$i].X -eq $SnakeBody[0].X -and $SnakeBody[$i].Y -eq $SnakeBody[0].Y) {
            $gameover = $true
        }
    }

    for($y = 0; $y -le $Height; $y++) {
        $line=""
        for($x = 0; $x -le $Width; $x++) {
            $contains = $false
            foreach($sg in $SnakeBody) {
                if ($sg.X -eq $x -and $sg.Y -eq $y) {
                    $contains = $true
                }
            }
            if ($contains) {
                Write-Host -NoNewline 'X' -ForegroundColor Red -BackgroundColor Red
            }
            elseif ($randomX -eq $x -and $randomY -eq $y) {
                Write-Host -NoNewline 'C' -ForegroundColor DarkYellow -BackgroundColor Yellow
            }
            else {
                switch($map[$x,$y]) {
                    "Grass1" { Write-Host -NoNewline 'n' -ForegroundColor Green -BackgroundColor DarkGreen; continue}
                    "Grass2" { Write-Host -NoNewline '-' -ForegroundColor Green -BackgroundColor DarkGreen; continue}
                    "Grass3" { Write-Host -NoNewline '.' -ForegroundColor Green -BackgroundColor DarkGreen; continue}
                }
            }
            if ($x -eq $Width) {
                echo ' '
            }
        }
    }
    Write-Host "Score: "$score
  }
  Start-Sleep -Milliseconds 100
} while(!$gameover)