@echo off
title Deploy Image to GitHub/Netlify
cd /d "%~dp0"
powershell.exe -ExecutionPolicy Bypass -File "%~dp0deploy-image.ps1"

