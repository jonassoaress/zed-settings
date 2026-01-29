param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot ".."))
)

$zedDir = Join-Path $env:APPDATA "Zed"
$srcSettings = Join-Path $RepoRoot "zed\settings.json"
$srcKeymap   = Join-Path $RepoRoot "zed\keymap.json"

New-Item -ItemType Directory -Force -Path $zedDir | Out-Null

function Ensure-Symlink($link, $target) {
  if (Test-Path $link) {
    Write-Host "Já existe: $link"
    return
  }
  if (-not (Test-Path $target)) {
    Write-Host "Alvo não existe ainda: $target (crie o arquivo e rode de novo)"
    return
  }
  New-Item -ItemType SymbolicLink -Path $link -Target $target | Out-Null
  Write-Host "Symlink criado: $link -> $target"
}

Ensure-Symlink (Join-Path $zedDir "settings.json") $srcSettings
Ensure-Symlink (Join-Path $zedDir "keymap.json")   $srcKeymap

Write-Host "OK. Reabra o Zed."
