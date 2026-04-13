@echo off
cd /d "%~dp0"
echo ========================================
echo Deploy to jdrfarm.com
echo ========================================
echo This pushes to GitHub. Netlify then builds
echo and publishes to your custom domain.
echo ========================================
echo.
git add -A
git status
echo.
git commit -m "Deploy website to jdrfarm.com"
if errorlevel 1 (
  echo Nothing to commit, or commit failed. Trying push anyway...
)
git push origin main
if errorlevel 1 (
  git push
)
if errorlevel 1 (
  echo.
  echo FAILED: Install Git from https://git-scm.com/download/win or use GitHub Desktop.
  pause
  exit /b 1
)
echo.
echo Done. In 1-2 minutes check: https://jdrfarm.com
echo Netlify: https://app.netlify.com
pause
