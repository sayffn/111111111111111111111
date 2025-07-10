@echo off
setlocal enabledelayedexpansion

echo 🔧 Starting Essentials Installation...

:: Install Chocolatey (only if not already installed)
where choco >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
     "Set-ExecutionPolicy Bypass -Scope Process; ^
      [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ^
      iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
)

:: Install all Visual C++ Redistributables
echo Installing vcredist packages...
choco install vcredist2005 vcredist2008 vcredist2010 vcredist2012 vcredist2013 vcredist2015 vcredist2017 vcredist-all -y

:: Check installations
echo Installed versions:
choco list --local-only | findstr /i "vcredist"

echo ✅ Essentials Installation Complete!

:: Optional: Run additional setup files (only if they exist)
if exist show.bat (
    echo Running show.bat...
    call show.bat
) else (
    echo ⚠️ show.bat not found
)

if exist loop.bat (
    echo Running loop.bat...
    call loop.bat
) else (
    echo ⚠️ loop.bat not found
)

echo 🎉 Downloads.bat finished.
pause
