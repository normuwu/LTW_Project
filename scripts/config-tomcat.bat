@echo off
chcp 65001 >nul
title PetVaccine - Cau hinh Tomcat
color 0E

echo ========================================================
echo           PETVACCINE - CAU HINH TOMCAT
echo ========================================================
echo.
echo Script nay se tu dong cap nhat duong dan Tomcat
echo trong cac file start.bat va scripts/deploy.bat
echo.
echo Vi du duong dan Tomcat:
echo   - C:\apache-tomcat-9.0.98
echo   - D:\tomcat9
echo   - E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113
echo.

set /p TOMCAT_PATH="Nhap duong dan thu muc Tomcat cua ban: "

:: Kiểm tra thư mục tồn tại
if not exist "%TOMCAT_PATH%" (
    echo.
    echo [X] Thu muc khong ton tai: %TOMCAT_PATH%
    echo     Vui long kiem tra lai duong dan.
    goto :end
)

:: Kiểm tra có phải Tomcat không
if not exist "%TOMCAT_PATH%\bin\startup.bat" (
    echo.
    echo [X] Day khong phai thu muc Tomcat hop le!
    echo     Khong tim thay file: %TOMCAT_PATH%\bin\startup.bat
    goto :end
)

echo.
echo [OK] Tim thay Tomcat tai: %TOMCAT_PATH%
echo.

:: Tạo file start.bat mới
echo Dang cap nhat start.bat...
cd /d "%~dp0.."

(
echo @echo off
echo echo ========================================
echo echo   PetVaccine - Starting Tomcat Server
echo echo ========================================
echo echo.
echo.
echo echo Step 1: Stopping old Tomcat if running...
echo taskkill /F /IM java.exe ^>nul 2^>^&1
echo timeout /t 2 /nobreak ^>nul
echo.
echo echo Step 2: Setting environment...
echo set CATALINA_HOME=%TOMCAT_PATH%
echo set CATALINA_BASE=%%CATALINA_HOME%%
echo.
echo echo Step 3: Starting Tomcat...
echo cd /d %%CATALINA_HOME%%\bin
echo call startup.bat
echo.
echo echo.
echo echo Step 4: Waiting for Tomcat to start ^(10 seconds^)...
echo timeout /t 10 /nobreak ^>nul
echo.
echo echo.
echo echo Opening browser...
echo start http://localhost:8080/PetVaccine/home
echo.
echo echo.
echo echo ========================================
echo echo   Server started successfully!
echo echo   URL: http://localhost:8080/PetVaccine/home
echo echo ========================================
) > start.bat

echo [OK] Da cap nhat start.bat
echo.

:: Tạo file deploy.bat mới
echo Dang cap nhat scripts/deploy.bat...

(
echo @echo off
echo cd /d "%%~dp0.."
echo echo Building project...
echo call mvn clean package -DskipTests -q
echo if %%ERRORLEVEL%% NEQ 0 ^(
echo     echo Build FAILED!
echo     pause
echo     exit /b 1
echo ^)
echo echo Deploying WAR to Tomcat...
echo copy /Y target\PetVaccine.war "%TOMCAT_PATH%\webapps\" ^>nul
echo if %%ERRORLEVEL%% EQU 0 ^(
echo     echo [OK] Deploy SUCCESS!
echo     echo     File: %TOMCAT_PATH%\webapps\PetVaccine.war
echo ^) else ^(
echo     echo [X] Deploy FAILED!
echo ^)
echo echo.
echo pause
) > scripts\deploy.bat

echo [OK] Da cap nhat scripts/deploy.bat
echo.

echo ========================================================
echo   CAU HINH HOAN TAT!
echo.
echo   Tomcat path: %TOMCAT_PATH%
echo.
echo   Bay gio ban co the:
echo   1. Chay scripts/deploy.bat de build va deploy
echo   2. Chay start.bat de khoi dong server
echo ========================================================

:end
echo.
echo Nhan phim bat ky de dong...
pause >nul
