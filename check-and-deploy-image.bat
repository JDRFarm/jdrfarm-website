@echo off
echo ========================================
echo Check and Deploy Image
echo ========================================
echo.
echo This will check if the image is tracked
echo and deploy it to GitHub/Netlify.
echo.

cd /d "%~dp0"

REM Try to find git
set GIT_CMD=
where git >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set GIT_CMD=git
    echo Git found in PATH.
) else (
    echo Git not in PATH. Trying GitHub Desktop path...
    if exist "%LOCALAPPDATA%\GitHubDesktop\resources\app\git\cmd\git.exe" (
        set "GIT_CMD=%LOCALAPPDATA%\GitHubDesktop\resources\app\git\cmd\git.exe"
        echo Git found in GitHub Desktop.
    ) else (
        echo ERROR: Git not found!
        echo Please use GitHub Desktop to commit and push.
        pause
        exit /b 1
    )
)

echo.
echo ========================================
echo Step 1: Check Git Status
echo ========================================
echo.

%GIT_CMD% status

echo.
echo ========================================
echo Step 2: Add Image File
echo ========================================
echo.

if exist "image\download (1).jpg" (
    echo Image file exists: image\download (1).jpg
    %GIT_CMD% add "image\download (1).jpg"
    echo Image file added to staging.
) else (
    echo ERROR: Image file not found!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Step 3: Add Updated HTML
echo ========================================
echo.

%GIT_CMD% add index.html
echo HTML file added to staging.

echo.
echo ========================================
echo Step 4: Commit Changes
echo ========================================
echo.

%GIT_CMD% commit -m "Add coconut oil product image - download (1).jpg"

echo.
echo ========================================
echo Step 5: Push to GitHub
echo ========================================
echo.

%GIT_CMD% push origin main
if %ERRORLEVEL% NEQ 0 (
    echo Trying master branch...
    %GIT_CMD% push origin master
)

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS!
    echo ========================================
    echo.
    echo Image has been pushed to GitHub!
    echo Netlify will automatically deploy in 1-2 minutes.
    echo.
    echo Check your site at: https://jdrfarm.com
    echo.
) else (
    echo.
    echo ========================================
    echo PUSH FAILED
    echo ========================================
    echo.
    echo Please push manually using GitHub Desktop:
    echo 1. Open GitHub Desktop
    echo 2. You should see the changes
    echo 3. Click "Commit to main"
    echo 4. Click "Push origin"
    echo.
)

pause

