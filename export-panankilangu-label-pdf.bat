@echo off
setlocal
set "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not exist "%CHROME%" set "CHROME=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if not exist "%CHROME%" (
  echo Chrome not found. Install Google Chrome or open print-panankilangu-sprouts-back-label.html and use Ctrl+P, Save as PDF.
  pause
  exit /b 1
)
cd /d "%~dp0"
set "P=%CD:\=/%"
set "URL=file:///%P%/print-panankilangu-sprouts-back-label.html?screenshot=1"
set "OUT=%CD%\jdr-panankilangu-sprouts-back-label.pdf"
"%CHROME%" --headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf="%OUT%" "%URL%"
echo.
echo Wrote: %OUT%
pause
