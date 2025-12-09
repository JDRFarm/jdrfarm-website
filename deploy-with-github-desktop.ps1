# Deploy using GitHub Desktop's Git
# Automatically pushes changes to GitHub

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Deploy to GitHub using GitHub Desktop" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

$repoPath = Get-Location
Write-Host "Repository: $repoPath" -ForegroundColor Cyan
Write-Host ""

# Find GitHub Desktop Git
$gitPaths = @(
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe",
    "$env:ProgramFiles\GitHub Desktop\resources\app\git\cmd\git.exe",
    "$env:ProgramFiles(x86)\GitHub Desktop\resources\app\git\cmd\git.exe",
    "$env:USERPROFILE\AppData\Local\GitHubDesktop\resources\app\git\cmd\git.exe"
)

$gitPath = $null
foreach ($path in $gitPaths) {
    if (Test-Path $path) {
        $gitPath = $path
        Write-Host "Found GitHub Desktop Git: $path" -ForegroundColor Green
        break
    }
}

# Also check if git is in PATH
if (-not $gitPath) {
    try {
        $null = Get-Command git -ErrorAction Stop
        $test = & git --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            $gitPath = "git"
            Write-Host "Found Git in PATH" -ForegroundColor Green
        }
    } catch {
        # Continue
    }
}

if (-not $gitPath) {
    Write-Host "Git not found. Trying to open GitHub Desktop..." -ForegroundColor Yellow
    Write-Host ""
    
    # Try to open GitHub Desktop
    $githubDesktopPaths = @(
        "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe",
        "$env:ProgramFiles\GitHub Desktop\GitHubDesktop.exe",
        "$env:ProgramFiles(x86)\GitHub Desktop\GitHubDesktop.exe",
        "$env:USERPROFILE\AppData\Local\GitHubDesktop\GitHubDesktop.exe"
    )
    
    foreach ($desktopPath in $githubDesktopPaths) {
        if (Test-Path $desktopPath) {
            Write-Host "Opening GitHub Desktop..." -ForegroundColor Cyan
            Start-Process $desktopPath
            Write-Host ""
            Write-Host "Please commit and push from GitHub Desktop:" -ForegroundColor Yellow
            Write-Host "1. Select the repository: jdrfarm-website" -ForegroundColor White
            Write-Host "2. Review changes (index.html and script.js)" -ForegroundColor White
            Write-Host "3. Commit message: Update branding from JDR Farm to JDR" -ForegroundColor White
            Write-Host "4. Click 'Push origin'" -ForegroundColor White
            Write-Host ""
            exit 0
        }
    }
    
    Write-Host "GitHub Desktop not found. Please install it or use Git directly." -ForegroundColor Red
    Write-Host "Download: https://desktop.github.com/" -ForegroundColor Cyan
    exit 1
}

Write-Host ""
Write-Host "Deploying changes..." -ForegroundColor Cyan
Write-Host ""

try {
    # Check if this is a git repository
    if ($gitPath -eq "git") {
        $gitCheck = & git rev-parse --git-dir 2>&1
    } else {
        $gitCheck = & $gitPath rev-parse --git-dir 2>&1
    }
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Initializing Git repository..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            & git init 2>&1 | Out-Null
            & git remote add origin https://github.com/JDRFarm/jdrfarm-website.git 2>&1 | Out-Null
        } else {
            & $gitPath init 2>&1 | Out-Null
            & $gitPath remote add origin https://github.com/JDRFarm/jdrfarm-website.git 2>&1 | Out-Null
        }
        Write-Host "✓ Repository initialized" -ForegroundColor Green
    }
    
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
    
    if ($commitResult -match "nothing to commit" -or $commitResult -match "no changes added") {
        Write-Host "No changes to commit (files may already be committed)" -ForegroundColor Yellow
    } else {
        Write-Host "✓ Committed: $commitMsg" -ForegroundColor Green
    }
    
    # Check current branch
    if ($gitPath -eq "git") {
        $currentBranch = & git branch --show-current 2>&1
        if (-not $currentBranch -or $currentBranch -match "error") {
            $currentBranch = "main"
        }
    } else {
        $currentBranch = & $gitPath branch --show-current 2>&1
        if (-not $currentBranch -or $currentBranch -match "error") {
            $currentBranch = "main"
        }
    }
    
    # Push
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    if ($gitPath -eq "git") {
        $pushResult = & git push -u origin $currentBranch 2>&1
        if ($LASTEXITCODE -ne 0) {
            $pushResult = & git push -u origin main 2>&1
        }
    } else {
        $pushResult = & $gitPath push -u origin $currentBranch 2>&1
        if ($LASTEXITCODE -ne 0) {
            $pushResult = & $gitPath push -u origin main 2>&1
        }
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "SUCCESS! Deployed to GitHub" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Repository: https://github.com/JDRFarm/jdrfarm-website" -ForegroundColor Cyan
        Write-Host "Live site: https://jdrfarm.com" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Changes will auto-deploy via Netlify/GitHub Pages" -ForegroundColor Yellow
        Write-Host "Deployment takes 1-2 minutes" -ForegroundColor Yellow
        Write-Host ""
        exit 0
    } else {
        Write-Host ""
        Write-Host "Push failed. Error:" -ForegroundColor Red
        $pushResult | Out-Host
        Write-Host ""
        Write-Host "You may need to:" -ForegroundColor Yellow
        Write-Host "1. Authenticate with GitHub" -ForegroundColor White
        Write-Host "2. Or use GitHub Desktop to push" -ForegroundColor White
        Write-Host ""
        
        # Try to open GitHub Desktop
        $githubDesktopPaths = @(
            "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe",
            "$env:ProgramFiles\GitHub Desktop\GitHubDesktop.exe",
            "$env:ProgramFiles(x86)\GitHub Desktop\GitHubDesktop.exe"
        )
        
        foreach ($desktopPath in $githubDesktopPaths) {
            if (Test-Path $desktopPath) {
                Write-Host "Opening GitHub Desktop for manual push..." -ForegroundColor Cyan
                Start-Process $desktopPath
                break
            }
        }
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Opening GitHub Desktop as fallback..." -ForegroundColor Yellow
    
    $githubDesktopPaths = @(
        "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe",
        "$env:ProgramFiles\GitHub Desktop\GitHubDesktop.exe",
        "$env:ProgramFiles(x86)\GitHub Desktop\GitHubDesktop.exe"
    )
    
    foreach ($desktopPath in $githubDesktopPaths) {
        if (Test-Path $desktopPath) {
            Start-Process $desktopPath
            break
        }
    }
}

Write-Host ""

