REM To use, hit Ctrl + S, then select "Save as type", and click "All files (*.*)". Make sure its name is "installer.bat".
REM If on Discord, hit the download button and run it.


@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul


cls
title SPECTR Installer // [#---------] Getting directory
color 0e


:: Thanks to tdcvoid for telling me the new path for Oculus
set "steamPath1=C:/Program Files (x86)/Steam/steamapps/common/Gorilla Tag"
set "steamPath2=C:/Program Files/Meta Horizon/Software/Software/another-axiom-gorilla-tag"


if exist "%steamPath1%" (
    set "gamePath=%steamPath1%"
) else if exist "%steamPath2%" (
    set "gamePath=%steamPath2%"
) else (
    color 0c
    echo Gorilla Tag directory not found.
    pause
    exit /b
)


if not defined gamePath (
    for %%D in (E F G H I J K L M N O P Q R S T U V W X Y Z) do (
        if exist "%%D:/SteamLibrary/steamapps/common/Gorilla Tag" (
            set "gamePath=%%D:/SteamLibrary/steamapps/common/Gorilla Tag"
            goto afterDriveSearch
        )
        if exist "%%D:/Steam/steamapps/common/Gorilla Tag" (
            set "gamePath=%%D:/Steam/steamapps/common/Gorilla Tag"
            goto afterDriveSearch
        )
    )
    color 0c
    echo Gorilla Tag directory not found on any drive.
    pause
    exit /b
)

:afterDriveSearch


color 0e
cls
title SPECTR Installer // [###-------] Downloading BepInEx
curl -L "https://github.com/BepInEx/BepInEx/releases/download/v5.4.23.4/BepInEx_win_x64_5.4.23.4.zip" -o BPNX54234.zip
if errorlevel 1 (
    color 0c
    echo Failed to download BepInEx. Check your internet connection.
    echo Error code: %errorlevel%
    pause
    exit /b
)


cls
title SPECTR Installer // [####------] Extracting BepInEx
powershell -command "Expand-Archive -Path 'BPNX54234.zip' -DestinationPath '%gamePath%' -Force"
if errorlevel 1 (
    color 0c
    echo Failed to extract BepInEx.
    echo Error code: %errorlevel%
    pause
    exit /b
)


cls
title SPECTR Installer // [#####-----] Creating directories
mkdir "%gamePath%/BepInEx/config" 2>nul
mkdir "%gamePath%/BepInEx/plugins" 2>nul


cls
title SPECTR Installer // [######----] Downloading SPECTR
for /f "tokens=*" %%i in ('powershell -Command "(Invoke-RestMethod -Uri 'https://api.github.com/repos/thatlonelydev/Spectr/releases/latest').assets | Where-Object { $_.name -eq 'Spectr.dll' } | Select-Object -ExpandProperty browser_download_url"') do (
    set spectrUrl=%%i
)


if "%spectrUrl%"=="" (
    color 0c
    echo Failed to find Spectr.dll in the latest release of SPECTR.
    pause
    exit /b
)


color 0e
curl -L "%spectrUrl%" -o "%gamePath%/BepInEx/plugins/Spectr.dll"
if errorlevel 1 (
    color 0c
    echo Failed to download Spectr.dll.
    echo Error code: %errorlevel%
    pause
    exit /b
)


cls
title SPECTR Installer // [##########] Finished
echo Congratulations, you now have SPECTR installed!


del "BPNX54234.zip" 2>nul


pause
