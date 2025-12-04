# Automatic GitHub Update Script
# This will prepare files and guide you through the update

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Automatic GitHub Update" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Verify script.js is updated
if (Test-Path "script.js") {
    $content = Get-Content "script.js" -Raw
    if ($content -match "9150150932" -and $content -match "sendWhatsAppMessage") {
        Write-Host "✓ script.js is updated with new changes" -ForegroundColor Green
    } else {
        Write-Host "✗ script.js needs to be updated" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✗ script.js not found" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Preparing for GitHub update..." -ForegroundColor Cyan
Write-Host ""

# Try to find Git in various locations
$gitPaths = @(
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe",
    "$env:ProgramFiles\Git\bin\git.exe"
)

$gitPath = $null
foreach ($path in $gitPaths) {
    if (Test-Path $path) {
        $gitPath = $path
        Write-Host "Found Git: $gitPath" -ForegroundColor Green
        break
    }
}

# Try git from PATH
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
    Write-Host "Attempting automatic push to GitHub..." -ForegroundColor Cyan
    Write-Host ""
    
    try {
        # Stage the file
        Write-Host "Staging script.js..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            & git add script.js 2>&1 | Out-Host
        } else {
            & $gitPath add script.js 2>&1 | Out-Host
        }
        
        # Commit
        Write-Host "Committing changes..." -ForegroundColor Yellow
        $commitMsg = "Update contact info to 9150150932 and info@jdrfarm.com, add WhatsApp order notification"
        if ($gitPath -eq "git") {
            $commitResult = & git commit -m $commitMsg 2>&1
        } else {
            $commitResult = & $gitPath commit -m $commitMsg 2>&1
        }
        $commitResult | Out-Host
        
        if ($commitResult -match "nothing to commit") {
            Write-Host "No changes to commit. Files may already be committed." -ForegroundColor Yellow
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
        $pushResult | Out-Host
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "========================================" -ForegroundColor Green
            Write-Host "SUCCESS! Updated on GitHub" -ForegroundColor Green
            Write-Host "========================================" -ForegroundColor Green
            Write-Host ""
            Write-Host "Netlify is now auto-deploying to your domain!" -ForegroundColor Cyan
            Write-Host "Check: https://app.netlify.com" -ForegroundColor White
            Write-Host "Live: https://jdrfarm.com" -ForegroundColor White
            Write-Host ""
            Write-Host "Deployment takes 1-2 minutes." -ForegroundColor Yellow
            Write-Host ""
            
            Start-Sleep -Seconds 2
            Start-Process "https://app.netlify.com"
            exit 0
        } else {
            Write-Host ""
            Write-Host "Push failed. Trying alternative method..." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

# Alternative: Open GitHub for manual update
Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "Opening GitHub for Update" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Since Git is not available, opening GitHub website..." -ForegroundColor Cyan
Write-Host ""

# Open GitHub repository
Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js"

Write-Host "GitHub editor opened in browser!" -ForegroundColor Green
Write-Host ""
Write-Host "The file is ready to edit. Follow these steps:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Find: async function confirmPayment()" -ForegroundColor White
Write-Host "2. Replace with updated code (see GITHUB_UPDATE_GUIDE.md)" -ForegroundColor White
Write-Host "3. Scroll down and commit" -ForegroundColor White
Write-Host "4. Netlify will auto-deploy!" -ForegroundColor Green
Write-Host ""

# Also open the guide
Start-Process "notepad.exe" -ArgumentList "$PSScriptRoot\GITHUB_UPDATE_GUIDE.md" -ErrorAction SilentlyContinue

Write-Host "Guide opened in Notepad for reference." -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

