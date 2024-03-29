﻿Remove-Variable -Name * -Force -ErrorAction SilentlyContinue

$mem_counter = Get-Counter   "\Память\% использования выделенной памяти" # "\Memory\% Committed Bytes In Use"
$mem = $mem_counter.Readings.Split()[5]
$mem = $mem.Split(',')
$mem = $mem[0]+"."+$mem[1].Remove(2)

$ts = ((New-TimeSpan -Start (Get-Date "01/01/1970") -End ($mem_counter.Timestamp)).TotalSeconds)*1E+9

$out = "memory_used,task=7"+" %memory_used="+"$mem"+" "+ [long]$ts
Write-Output $out
Remove-Variable -Name * -Force -ErrorAction SilentlyContinue
