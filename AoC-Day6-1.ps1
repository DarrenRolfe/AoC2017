[int[]]$array = "2	8	8	5	4	2	3	1	5	5	1	2	15	13	5	14" -split("`t")

<# >
[int[]]$array = "0 2 7 0" -split(" ")
#>

### start at first biggest value!


$pos = 0
$jumps = 0
$newvalue = 0
$value = 0
$term = 0
[string[]]$record = @()

do {
    $posvalue = ($array | measure -Maximum).Maximum
    #$pos = ($array | measure -Maximum)
    $findpos = 0
    Remove-Variable pos
    do {
        if (($array[$findpos] | measure -Maximum).Maximum -eq $posvalue) {
            $pos = $findpos
            $posset = 1
            Write-Host "Starting from position: $pos"
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
    foreach ($entry in $record) {
        if ($entry -match $makerecord) {
            $term = 1
            Write-Host "Match Found in $jumps redistributions"
        }
    }
    $record += $makerecord
    Write-Host "Record #$jumps : $makerecord"
} until ($term -eq 1)
