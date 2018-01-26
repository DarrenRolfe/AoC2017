[int[]]$array = "2	8	8	5	4	2	3	1	5	5	1	2	15	13	5	14" -split("`t")

<# >
[int[]]$array = "0 2 7 0" -split(" ")
#>

### start at first biggest value!

$term = 0
$pos = 0
$jumps = 0
$newvalue = 0
$value = 0
[string[]]$record = @()

do {
    do {
        $posvalue = ($array | measure -Maximum).Maximum
        #$pos = ($array | measure -Maximum)
        $findpos = 0
        Remove-Variable pos
        do {
            if (($array[$findpos] | measure -Maximum).Maximum -eq $posvalue) {
                $pos = $findpos
                $posset = 1
                #Write-Host "Starting from position: $pos"
            }
            $findpos++
        } until ($posset -eq 1)
        $posset = 0
        #Write-Host "DEBUG: $pos $posvalue"
        [int]$value = $array[$pos]
        #$array.Set($pos,0)
        $array[$pos] = 0
        do {
            $pos += 1
            if ($pos -eq $array.Length) {
                $pos = 0
            }
            [int]$posvalue = $array[$pos]
            $posvalue += 1
            #$array.Set($pos,$posvalue)
            $array[$pos] = $posvalue
            $value -= 1
            #Write-Host "DEBUG: $pos $posvalue $value"
        } until ($value -eq 0)

        $makerecord = [system.String]::Join("",$array)
        $makerecord = $makerecord.Trim()
        #Write-Host "DEBUG: $makerecord"
        $jumps++
        if ($term -lt 1) {
            foreach ($entry in $record) {
                if ($entry -match $makerecord) {
                    $term++
                    Write-Host "Match Found in $jumps redistributions" -ForegroundColor Yellow
                    $posmatch = $jumps-1
                    $jumps = 0
                }
            }
        } elseif ($term -eq 1) {
            if ($makerecord -match $record[$posmatch]) {
                $term++
                Write-Host "Second Match Found in $jumps redistributions" -ForegroundColor Cyan
            }
        }
        $record += $makerecord
        #Write-Host "Record #$jumps : $makerecord" -ForegroundColor Yellow
    } until ($term -gt 0)
} until ($term -eq 2)