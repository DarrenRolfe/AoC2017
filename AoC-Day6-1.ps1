[int[]]$array = "2	8	8	5	4	2	3	1	5	5	1	2	15	13	5	14" -split("`t")

<# #
[int[]]$array = "0
2
3" -split("`n")
#>

### start at first biggest value!


$pos = 0
$jumps = 0
$newvalue = 0
$value = 0
$term = 0
[string[]]$record = @()

do {
    [int]$value = $array[$pos]
    $array.Set($pos,0)
    do {
        $pos += 1
        if ($pos -eq $array.Length) {
            $pos = 0
        }
        [int]$posvalue = $array[$pos]
        $posvalue += 1
        $array.Set($pos,$posvalue)
        $value -= 1
    } until ($value -eq 0)

    $makerecord = [system.String]::Join("",$array)
    $makerecord = $makerecord.Trim()
    foreach ($entry in $record) {
        if ($entry -match $makerecord) {
            $term = 1
            Write-Host "Match Found in $jumps redistributions"
        }
    }
    $record += $makerecord

    $jumps++
} until ($term -eq 1)
