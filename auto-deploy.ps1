# Automatic GitHub Deployment Script
# Watches for file changes and automatically commits and pushes to GitHub

$repoPath = $PSScriptRoot
$gitPath = $null

# Try to find git executable
$gitPaths = @(
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe",
    "git"  # Try PATH as last resort
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
    Write-Host "ERROR: Git not found. Please install Git or GitHub Desktop." -ForegroundColor Red
    Write-Host "Tried paths:" -ForegroundColor Yellow
    $gitPaths | ForEach-Object { Write-Host "  - $_" }
    Write-Host "`nPlease install Git from: https://git-scm.com/download/win" -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "========================================" -ForegroundColor Green
Write-Host "Auto-Deploy to GitHub - Active" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "Repository: $repoPath" -ForegroundColor Cyan
Write-Host "Git: $gitPath" -ForegroundColor Cyan
Write-Host "`nWatching for file changes..." -ForegroundColor Yellow
Write-Host "Press Ctrl+C to stop`n" -ForegroundColor Gray

# Function to commit and push
function Commit-AndPush {
    param([string]$changeType, [string]$filePath)
    
    $fileName = Split-Path $filePath -Leaf
    Write-Host "`n[$([DateTime]::Now.ToString('HH:mm:ss'))] Change detected: $changeType - $fileName" -ForegroundColor Magenta
    
    # Change to repository directory
    Push-Location $repoPath
    
    try {
        # Add all changes
        if ($gitPath -eq "git") {
            & git add .
        } else {
            & $gitPath add .
        }
        
        # Create commit message
        $commitMessage = "Auto-deploy: $changeType - $fileName at $([DateTime]::Now.ToString('yyyy-MM-dd HH:mm:ss'))"
        
        # Commit
        if ($gitPath -eq "git") {
            $commitResult = & git commit -m $commitMessage 2>&1
        } else {
            $commitResult = & $gitPath commit -m $commitMessage 2>&1
        }
        
        # Check if there were changes to commit
        if ($commitResult -match "nothing to commit" -or $commitResult -match "no changes added to commit") {
            Write-Host "  No changes to commit (may be duplicate event)" -ForegroundColor Gray
            return
        }
        
        Write-Host "  ✓ Committed changes" -ForegroundColor Green
        
        # Push to GitHub
        Write-Host "  → Pushing to GitHub..." -ForegroundColor Yellow
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
            Write-Host "  ✓ Successfully pushed to GitHub!" -ForegroundColor Green
            Write-Host "  → Netlify will automatically deploy in 1-2 minutes" -ForegroundColor Cyan
            Write-Host "  → Check Netlify dashboard for deployment status" -ForegroundColor Cyan
            Write-Host "  → Your site will be live at: https://jdrfarm.com" -ForegroundColor Green
        } else {
            Write-Host "  ✗ Push failed: $pushResult" -ForegroundColor Red
            Write-Host "  → You may need to push manually via GitHub Desktop" -ForegroundColor Yellow
        }
        
    } catch {
        Write-Host "  ✗ Error: $_" -ForegroundColor Red
    } finally {
        Pop-Location
    }
}

# Create file system watcher
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $repoPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

# Filter for relevant file types
$watcher.Filter = "*.*"
$watcher.NotifyFilter = [System.IO.NotifyFilters]::FileName -bor 
                        [System.IO.NotifyFilters]::LastWrite -bor
                        [System.IO.NotifyFilters]::Size

# Debounce timer to avoid multiple commits for rapid changes
$debounceTimer = $null
$pendingChanges = @{}

# Register event handlers
Register-ObjectEvent -InputObject $watcher -EventName "Changed" -Action {
    $path = $Event.SourceEventArgs.FullPath
    $changeType = $Event.SourceEventArgs.ChangeType
    
    # Ignore .git directory and temporary files
    if ($path -match '\.git' -or $path -match '~$' -or $path -match '\.tmp$') {
        return
    }
    
    # Store change
    $script:pendingChanges[$path] = $changeType
    
    # Clear existing timer
    if ($script:debounceTimer) {
        $script:debounceTimer.Dispose()
    }
    
    # Set new timer (wait 3 seconds for batch changes)
    $script:debounceTimer = New-Object System.Timers.Timer(3000)
    $script:debounceTimer.AutoReset = $false
    Register-ObjectEvent -InputObject $script:debounceTimer -EventName "Elapsed" -Action {
        # Process all pending changes
        foreach ($change in $script:pendingChanges.GetEnumerator()) {
            Commit-AndPush -changeType $change.Value -filePath $change.Key
        }
        $script:pendingChanges.Clear()
        $script:debounceTimer.Dispose()
        $script:debounceTimer = $null
    } | Out-Null
    $script:debounceTimer.Start()
} | Out-Null

Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action {
    $path = $Event.SourceEventArgs.FullPath
    if ($path -notmatch '\.git') {
        $script:pendingChanges[$path] = "Created"
        
        if ($script:debounceTimer) {
            $script:debounceTimer.Dispose()
        }
        
        $script:debounceTimer = New-Object System.Timers.Timer(3000)
        $script:debounceTimer.AutoReset = $false
        Register-ObjectEvent -InputObject $script:debounceTimer -EventName "Elapsed" -Action {
            foreach ($change in $script:pendingChanges.GetEnumerator()) {
                Commit-AndPush -changeType $change.Value -filePath $change.Key
            }
            $script:pendingChanges.Clear()
            $script:debounceTimer.Dispose()
            $script:debounceTimer = $null
        } | Out-Null
        $script:debounceTimer.Start()
    }
} | Out-Null

Register-ObjectEvent -InputObject $watcher -EventName "Deleted" -Action {
    $path = $Event.SourceEventArgs.FullPath
    if ($path -notmatch '\.git') {
        Commit-AndPush -changeType "Deleted" -filePath $path
    }
} | Out-Null

# Keep script running
try {
    Write-Host "File watcher started successfully!`n" -ForegroundColor Green
    while ($true) {
        Start-Sleep -Seconds 1
    }
} finally {
    $watcher.EnableRaisingEvents = $false
    $watcher.Dispose()
    Write-Host "`nFile watcher stopped." -ForegroundColor Yellow
}

