# Push image to GitHub and trigger Netlify deployment

$repoPath = $PSScriptRoot
$gitPath = $null

# Try to find git executable
$gitPaths = @(
    "git",
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe"
)

foreach ($path in $gitPaths) {
    if ($path -eq "git") {
        try {
            $null = Get-Command git -ErrorAction Stop
            $gitPath = "git"
            break
        } catch {
            continue
        }
    } elseif (Test-Path $path) {
        $gitPath = $path
        break
    }
}

if (-not $gitPath) {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "Git not found!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please use GitHub Desktop:" -ForegroundColor Yellow
    Write-Host "1. Open GitHub Desktop" -ForegroundColor Cyan
    Write-Host "2. You should see 'image/download (1).jpg' in changes" -ForegroundColor Cyan
    Write-Host "3. Add commit message: 'Add coconut oil product image'" -ForegroundColor Cyan
    Write-Host "4. Click 'Commit to main'" -ForegroundColor Cyan
    Write-Host "5. Click 'Push origin'" -ForegroundColor Cyan
    Write-Host ""
    pause
    exit 1
}

Write-Host "========================================" -ForegroundColor Green
Write-Host "Pushing Image to GitHub" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Push-Location $repoPath

try {
    Write-Host "Adding image file..." -ForegroundColor Yellow
    if ($gitPath -eq "git") {
        & git add "image/download (1).jpg"
        & git add index.html
    } else {
        & $gitPath add "image/download (1).jpg"
        & $gitPath add index.html
    }
    
    Write-Host "Committing changes..." -ForegroundColor Yellow
    $commitMessage = "Add coconut oil product image - download (1).jpg"
    if ($gitPath -eq "git") {
        $commitResult = & git commit -m $commitMessage 2>&1
    } else {
        $commitResult = & $gitPath commit -m $commitMessage 2>&1
    }
    
    if ($commitResult -match "nothing to commit" -or $commitResult -match "no changes added") {
        Write-Host "No changes to commit (may already be committed)" -ForegroundColor Gray
    } else {
        Write-Host "✓ Committed changes" -ForegroundColor Green
    }
    
    Write-Host ""
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
        Write-Host "SUCCESS! Image pushed to GitHub!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Netlify will automatically deploy in 1-2 minutes." -ForegroundColor Cyan
        Write-Host "Check: https://app.netlify.com → Deploys tab" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Your site will update at: https://jdrfarm.com" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Red
        Write-Host "Push failed!" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please push manually via GitHub Desktop:" -ForegroundColor Yellow
        Write-Host "1. Open GitHub Desktop" -ForegroundColor Cyan
        Write-Host "2. Commit and push changes" -ForegroundColor Cyan
    }
    
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
} finally {
    Pop-Location
}

Write-Host ""
pause

