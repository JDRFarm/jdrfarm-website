@echo off
echo ========================================
echo Push Image to GitHub and Netlify
echo ========================================
echo.
echo This will commit and push the image file
echo to GitHub, which will trigger Netlify deployment.
echo.
pause

cd /d "%~dp0"

REM Try to find git
set GIT_CMD=
where git >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set GIT_CMD=git
) else (
    if exist "C:\Program Files\Git\bin\git.exe" (
        set "GIT_CMD=C:\Program Files\Git\bin\git.exe"
    ) else if exist "%LOCALAPPDATA%\GitHubDesktop\resources\app\git\cmd\git.exe" (
        set "GIT_CMD=%LOCALAPPDATA%\GitHubDesktop\resources\app\git\cmd\git.exe"
    )
)

if "%GIT_CMD%"=="" (
    echo.
    echo ERROR: Git not found!
    echo.
    echo Please use GitHub Desktop:
    echo 1. Open GitHub Desktop
    echo 2. You should see "image/download (1).jpg" in changes
    echo 3. Add commit message: "Add coconut oil product image"
    echo 4. Click "Commit to main"
    echo 5. Click "Push origin"
    echo.
    pause
    exit /b 1
)

echo.
echo Adding image file to git...
"%GIT_CMD%" add "image/download (1).jpg"
"%GIT_CMD%" add index.html

echo.
echo Committing changes...
"%GIT_CMD%" commit -m "Add coconut oil product image - download (1).jpg"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo No changes to commit, or already committed.
    echo.
)

echo.
echo Pushing to GitHub...
"%GIT_CMD%" push origin main
if %ERRORLEVEL% NEQ 0 (
    "%GIT_CMD%" push origin master
)

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! Image pushed to GitHub!
    echo ========================================
    echo.
    echo Netlify will automatically deploy in 1-2 minutes.
    echo Check: https://app.netlify.com -^> Deploys tab
    echo.
    echo Your site will update at: https://jdrfarm.com
    echo.
) else (
    echo.
    echo ========================================
    echo Push failed!
    echo ========================================
    echo.
    echo Please push manually via GitHub Desktop:
    echo 1. Open GitHub Desktop
    echo 2. Commit and push changes
    echo.
)

pause

