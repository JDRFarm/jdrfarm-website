# Auto Deploy to GitHub
# Automatically pushes local changes to GitHub repository

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Auto Deploy to GitHub" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

$repoPath = Get-Location
Write-Host "Repository: $repoPath" -ForegroundColor Cyan
Write-Host ""

# Verify files exist
$filesToUpdate = @("index.html", "script.js")
foreach ($file in $filesToUpdate) {
    if (-not (Test-Path $file)) {
        Write-Host "Error: $file not found" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✓ Files verified" -ForegroundColor Green
Write-Host ""

# Try to find Git in multiple locations
$gitPaths = @(
    "git",
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe",
    "$env:ProgramFiles\Git\bin\git.exe",
    "$env:ProgramFiles(x86)\Git\bin\git.exe",
    "$env:USERPROFILE\AppData\Local\Programs\Git\bin\git.exe"
)

$gitPath = $null
foreach ($path in $gitPaths) {
    if ($path -eq "git") {
        try {
            $null = Get-Command git -ErrorAction Stop
            $test = & git --version 2>&1
            if ($LASTEXITCODE -eq 0) {
                $gitPath = "git"
                Write-Host "Found Git in PATH" -ForegroundColor Green
                break
            }
        } catch {
            continue
        }
    } elseif (Test-Path $path) {
        $gitPath = $path
        Write-Host "Found Git: $path" -ForegroundColor Green
        break
    }
}

if ($gitPath) {
    Write-Host ""
    Write-Host "Using Git to deploy..." -ForegroundColor Cyan
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
        }
        
        # Stage all files
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
            Write-Host "No changes to commit" -ForegroundColor Yellow
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
            Write-Host ""
            exit 0
        } else {
            Write-Host ""
            Write-Host "Push failed. Error:" -ForegroundColor Red
            $pushResult | Out-Host
            Write-Host ""
            Write-Host "You may need to:" -ForegroundColor Yellow
            Write-Host "1. Set up Git credentials" -ForegroundColor White
            Write-Host "2. Or use GitHub Desktop" -ForegroundColor White
            Write-Host ""
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
} else {
    Write-Host "Git not found in standard locations" -ForegroundColor Yellow
    Write-Host ""
}

# If Git not available, try GitHub CLI
Write-Host "Trying GitHub CLI..." -ForegroundColor Cyan
$ghPath = Get-Command gh -ErrorAction SilentlyContinue
if ($ghPath) {
    Write-Host "Found GitHub CLI!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Note: GitHub CLI requires authentication" -ForegroundColor Yellow
    Write-Host "Run: gh auth login" -ForegroundColor White
    Write-Host ""
}

# Final fallback: Open GitHub web interface
Write-Host ""
Write-Host "Opening GitHub web interface for manual update..." -ForegroundColor Yellow
Write-Host ""

# Read file contents to display
$indexContent = Get-Content "index.html" -Raw
$scriptContent = Get-Content "script.js" -Raw

# Create a summary file
$summaryFile = "DEPLOYMENT_SUMMARY.txt"
$summaryLines = @(
    "========================================",
    "DEPLOYMENT SUMMARY",
    "========================================",
    "",
    "Files Updated:",
    "- index.html: Updated 'JDR Farm' to 'JDR'",
    "- script.js: Updated 'JDR Farm' to 'JDR' in translations",
    "",
    "Commit Message:",
    "Update branding from JDR Farm to JDR",
    "",
    "GitHub Repository:",
    "https://github.com/JDRFarm/jdrfarm-website",
    "",
    "To Deploy:",
    "1. Go to: https://github.com/JDRFarm/jdrfarm-website",
    "2. Edit index.html and script.js",
    "3. Copy content from local files",
    "4. Commit with message: Update branding from JDR Farm to JDR",
    "",
    "Files are ready in:",
    $repoPath,
    ""
)
$summaryLines | Out-File -FilePath $summaryFile -Encoding UTF8

Write-Host "Created deployment summary: $summaryFile" -ForegroundColor Green
Write-Host ""

# Open GitHub
Start-Process "https://github.com/JDRFarm/jdrfarm-website"
Start-Sleep -Seconds 2
Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/index.html"
Start-Sleep -Seconds 1
Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js"
Start-Sleep -Seconds 1
Start-Process notepad.exe -ArgumentList "$repoPath\$summaryFile"

Write-Host "GitHub editors and summary file opened!" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "1. Copy content from local files to GitHub editors" -ForegroundColor White
Write-Host "2. Commit with message: Update branding from JDR Farm to JDR" -ForegroundColor White
Write-Host "3. Changes will auto-deploy" -ForegroundColor White
Write-Host ""

