# Installs the two skills that ui-ux-suite depends on (ui-styles and ux-laws)
# next to it, in the same skills folder. Safe to run again: it updates them.
#
#   Set-Location "$HOME\.claude\skills"
#   git clone https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
#   .\ui-ux-suite\install.ps1                  # newest versions (main)
#   .\ui-ux-suite\install.ps1 -Ref v1.2.1      # a tag or branch, for the two companions
#
# This script is for people, not for the agent. The skill never runs it.
param([string]$Ref = "main")

# Windows PowerShell 5.1 turns anything git writes to stderr into an error, so
# check git's exit code ourselves instead of relying on $ErrorActionPreference.
$ErrorActionPreference = "Continue"

function Invoke-Git {
  & git @args
  if ($LASTEXITCODE -ne 0) { throw "git $($args -join ' ') failed (exit $LASTEXITCODE)" }
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "git is required but was not found." }

$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
$Parent = Split-Path -Parent $Here
if ((Split-Path -Leaf $Here) -ne "ui-ux-suite") {
  Write-Warning "This folder is called '$(Split-Path -Leaf $Here)'. It must be called 'ui-ux-suite' to match the skill name."
}

function Install-One($Name, $Url) {
  $Target = Join-Path $Parent $Name
  if (Test-Path (Join-Path $Target ".git")) {
    Write-Host "Updating $Name to $Ref ..."
    Invoke-Git -C $Target fetch --quiet --tags origin
    Invoke-Git -C $Target -c advice.detachedHead=false checkout --quiet $Ref
    & git -C $Target symbolic-ref --quiet HEAD *> $null
    if ($LASTEXITCODE -eq 0) { Invoke-Git -C $Target pull --quiet --ff-only origin $Ref }
  } elseif (Test-Path $Target) {
    throw "$Target exists but is not a git checkout. Move it away and run this again."
  } else {
    Write-Host "Installing $Name ($Ref) ..."
    Invoke-Git -c advice.detachedHead=false clone --quiet --branch $Ref $Url $Target
  }
}

Install-One "ui-styles" "https://github.com/JohnSina86/ui-styles-skill.git"
Install-One "ux-laws"   "https://github.com/JohnSina86/ux-laws-skill.git"

Write-Host ""
Write-Host "Installed in: $Parent"
$AllOk = $true
foreach ($Name in "ui-styles", "ux-laws", "ui-ux-suite") {
  $Dir = Join-Path $Parent $Name
  if (Test-Path (Join-Path $Dir "SKILL.md")) {
    $Ver = & git -C $Dir describe --tags --always 2>$null
    Write-Host "  OK  $Name  ($Ver)"
  } else { Write-Host "  MISSING  $Name\SKILL.md"; $AllOk = $false }
}
if (-not $AllOk) { throw "Something is missing. See the lines above." }
Write-Host "Done. Start a new agent session so it picks the skills up."
