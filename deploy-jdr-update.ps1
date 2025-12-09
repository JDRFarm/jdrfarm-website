# Deploy JDR Name Update to GitHub
# Updates "JDR Farm" to "JDR" and pushes to GitHub

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Deploy JDR Name Update to GitHub" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

$repoPath = Get-Location
Write-Host "Repository: $repoPath" -ForegroundColor Cyan
Write-Host ""

# Verify files exist
if (-not (Test-Path "index.html")) {
    Write-Host "Error: index.html not found" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path "script.js")) {
    Write-Host "Error: script.js not found" -ForegroundColor Red
    exit 1
}

Write-Host "✓ Files verified" -ForegroundColor Green
Write-Host ""

# Try to find Git
$gitPaths = @(
    "git",
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe",
    "$env:ProgramFiles\Git\bin\git.exe"
)

$gitPath = $null
foreach ($path in $gitPaths) {
    if ($path -eq "git") {
        try {
            $null = Get-Command git -ErrorAction Stop
            $test = & git --version 2>&1
            if ($LASTEXITCODE -eq 0) {
                $gitPath = "git"
                break
            }
        } catch {
            continue
        }
    } elseif (Test-Path $path) {
        $gitPath = $path
        break
    }
}

if ($gitPath) {
    Write-Host "Found Git: $gitPath" -ForegroundColor Green
    Write-Host ""
    
    try {
        # Stage files
        Write-Host "Staging files..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            & git add index.html script.js 2>&1 | Out-Null
        } else {
            & $gitPath add index.html script.js 2>&1 | Out-Null
        }
        Write-Host "✓ Files staged" -ForegroundColor Green
        
        # Commit
        Write-Host "Committing changes..." -ForegroundColor Yellow
        $commitMsg = "Update branding from JDR Farm to JDR"
        if ($gitPath -eq "git") {
            $commitResult = & git commit -m $commitMsg 2>&1
        } else {
            $commitResult = & $gitPath commit -m $commitMsg 2>&1
        }
        
        if ($commitResult -match "nothing to commit") {
            Write-Host "No changes to commit (may already be committed)" -ForegroundColor Yellow
        } else {
            Write-Host "✓ Committed: $commitMsg" -ForegroundColor Green
        }
        
        # Push
        Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            $pushResult = & git push origin main 2>&1
            if ($LASTEXITCODE -ne 0) {
                $pushResult = & git push origin master 2>&1
            }
        } else {
            $pushResult = & $gitPath push origin main 2>&1
            if ($LASTEXITCODE -ne 0) {
                $pushResult = & $gitPath push origin master 2>&1
            }
        }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "========================================" -ForegroundColor Green
            Write-Host "SUCCESS! Pushed to GitHub" -ForegroundColor Green
            Write-Host "========================================" -ForegroundColor Green
            Write-Host ""
            Write-Host "Repository: https://github.com/JDRFarm/jdrfarm-website" -ForegroundColor Cyan
            Write-Host "Live site: https://jdrfarm.com" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Deployment will be automatic via Netlify/GitHub Pages" -ForegroundColor Yellow
            Write-Host ""
            exit 0
        } else {
            Write-Host ""
            Write-Host "Push failed:" -ForegroundColor Red
            $pushResult | Out-Host
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

# If Git not found, open GitHub for manual update
Write-Host ""
Write-Host "Git not found. Opening GitHub for manual update..." -ForegroundColor Yellow
Write-Host ""

Start-Process "https://github.com/JDRFarm/jdrfarm-website"
Start-Sleep -Seconds 1
Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/index.html"
Start-Sleep -Seconds 1
Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js"

Write-Host "GitHub editors opened!" -ForegroundColor Green
Write-Host ""
Write-Host "Files to update:" -ForegroundColor Cyan
Write-Host "1. index.html - Update all 'JDR Farm' to 'JDR'" -ForegroundColor White
Write-Host "2. script.js - Update all 'JDR Farm' to 'JDR' in translations" -ForegroundColor White
Write-Host ""
Write-Host "Commit message:" -ForegroundColor Cyan
Write-Host 'Update branding from JDR Farm to JDR' -ForegroundColor White
Write-Host ""

