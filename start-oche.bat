@echo off
title Oche Darts
cd /d "%~dp0"
if not exist "oche-darts.html" (
  echo oche-darts.html staat niet in deze map. Zet beide bestanden in dezelfde map.
  pause
  exit /b
)
echo Oche Darts draait op http://localhost:8765
echo Laat dit venster open zolang je speelt. Sluiten = app stoppen.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$l=New-Object Net.HttpListener; $l.Prefixes.Add('http://localhost:8765/'); try{$l.Start()}catch{Write-Host 'Poort 8765 is al in gebruik. Draait Oche al? Open dan http://localhost:8765 in Chrome.'; Start-Process 'http://localhost:8765/'; Start-Sleep 8; exit}; Start-Process 'http://localhost:8765/'; $f=Join-Path (Get-Location) 'oche-darts.html'; while($l.IsListening){ $c=$l.GetContext(); try{ $b=[IO.File]::ReadAllBytes($f); $c.Response.ContentType='text/html; charset=utf-8'; $c.Response.Headers.Add('Cache-Control','no-store'); $c.Response.OutputStream.Write($b,0,$b.Length) }catch{ $c.Response.StatusCode=500 }; $c.Response.Close() }"
