# Force Deploy Script - Payment Feature
# This script will attempt multiple methods to deploy

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Force Deploy - Payment Feature" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Check if we're in the right directory
if (-not (Test-Path "index.html")) {
    Write-Host "Error: index.html not found. Please run from jdrfarm-website directory." -ForegroundColor Red
    exit 1
}

Write-Host "✓ Repository files found" -ForegroundColor Green
Write-Host ""

# Method 1: Try to find Git in various locations
$gitPaths = @(
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe",
    "$env:ProgramFiles\Git\bin\git.exe",
    "$env:ProgramFiles(x86)\Git\bin\git.exe"
)

$gitPath = $null
foreach ($path in $gitPaths) {
    if (Test-Path $path) {
        $gitPath = $path
        Write-Host "Found Git: $gitPath" -ForegroundColor Green
        break
    }
}

# Method 2: Try git from PATH
if (-not $gitPath) {
    try {
        $null = Get-Command git -ErrorAction Stop
        $gitPath = "git"
        Write-Host "Found Git in PATH" -ForegroundColor Green
    } catch {
        Write-Host "Git not found in PATH" -ForegroundColor Yellow
    }
}

if ($gitPath) {
    Write-Host ""
    Write-Host "Attempting deployment via Git..." -ForegroundColor Cyan
    Write-Host ""
    
    try {
        # Check status
        Write-Host "Checking git status..." -ForegroundColor Yellow
        & $gitPath status --short 2>&1 | Out-Host
        
        # Add all changes
        Write-Host "Staging all changes..." -ForegroundColor Yellow
        & $gitPath add . 2>&1 | Out-Host
        
        # Commit
        Write-Host "Committing changes..." -ForegroundColor Yellow
        $commitResult = & $gitPath commit -m "Add GPay/UPI QR code payment feature with email notifications" 2>&1
        $commitResult | Out-Host
        
        if ($commitResult -match "nothing to commit") {
            Write-Host "No changes to commit. Files may already be committed." -ForegroundColor Yellow
        }
        
        # Push
        Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
        $pushResult = & $gitPath push origin main 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Trying master branch..." -ForegroundColor Yellow
            $pushResult = & $gitPath push origin master 2>&1
        }
        $pushResult | Out-Host
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "========================================" -ForegroundColor Green
            Write-Host "SUCCESS! Deployed to GitHub" -ForegroundColor Green
            Write-Host "========================================" -ForegroundColor Green
            Write-Host ""
            Write-Host "Netlify will auto-deploy in 1-2 minutes" -ForegroundColor Cyan
            Write-Host "Check: https://app.netlify.com" -ForegroundColor White
            Write-Host "Live: https://jdrfarm.com" -ForegroundColor White
            Start-Sleep -Seconds 2
            Start-Process "https://app.netlify.com"
            exit 0
        } else {
            Write-Host ""
            Write-Host "Push failed. Error details above." -ForegroundColor Red
        }
    } catch {
        Write-Host "Error during Git operations: $_" -ForegroundColor Red
    }
}

# If Git methods failed, provide manual instructions
Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "Manual Deployment Required" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Git not found or push failed. Please use one of these methods:" -ForegroundColor Cyan
Write-Host ""
Write-Host "Method 1: GitHub Desktop (Easiest)" -ForegroundColor White
Write-Host "1. Open GitHub Desktop" -ForegroundColor Gray
Write-Host "2. Select: jdrfarm-website repository" -ForegroundColor Gray
Write-Host "3. Commit message: 'Add GPay/UPI QR code payment feature with email notifications'" -ForegroundColor Gray
Write-Host "4. Click 'Commit to main'" -ForegroundColor Gray
Write-Host "5. Click 'Push origin'" -ForegroundColor Gray
Write-Host ""
Write-Host "Method 2: GitHub Website" -ForegroundColor White
Write-Host "1. Go to: https://github.com/JDRFarm/jdrfarm-website" -ForegroundColor Gray
Write-Host "2. Click 'Upload files'" -ForegroundColor Gray
Write-Host "3. Upload: index.html, script.js, styles.css" -ForegroundColor Gray
Write-Host "4. Commit message: 'Add GPay/UPI QR code payment feature with email notifications'" -ForegroundColor Gray
Write-Host "5. Click 'Commit changes'" -ForegroundColor Gray
Write-Host ""

# Open helpful resources
Write-Host "Opening GitHub Desktop and folder..." -ForegroundColor Cyan
Start-Process "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe" -ErrorAction SilentlyContinue
Start-Process explorer.exe -ArgumentList (Get-Location)
Start-Process "https://github.com/JDRFarm/jdrfarm-website" -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

