@echo off
REM ============================================
REM PetVaccine WAR Deployment Script
REM ============================================
REM Script này deploy WAR file từ Maven build
REM KHÔNG ảnh hưởng đến deploy script cũ
REM ============================================

setlocal enabledelayedexpansion

set TOMCAT_HOME=E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113
set WEBAPPS=%TOMCAT_HOME%\webapps
set WAR_NAME=PetVaccine.war
set APP_NAME=PetVaccine

echo ============================================
echo PetVaccine WAR Deployment
echo ============================================
echo.

REM Step 1: Build WAR with Maven
echo [1/4] Building WAR with Maven...
call mvn clean package -q
if %ERRORLEVEL% neq 0 (
    echo ERROR: Maven build failed!
    exit /b 1
)
echo      Build successful: target\%WAR_NAME%
echo.

REM Step 2: Stop Tomcat if running
echo [2/4] Checking Tomcat status...
tasklist /FI "IMAGENAME eq java.exe" 2>NUL | find /I "java.exe" >NUL
if %ERRORLEVEL% equ 0 (
    echo      Stopping Tomcat...
    call "%TOMCAT_HOME%\bin\shutdown.bat" >NUL 2>&1
    timeout /t 5 /nobreak >NUL
)
echo      Tomcat stopped.
echo.

REM Step 3: Remove old deployment
echo [3/4] Removing old deployment...
if exist "%WEBAPPS%\%APP_NAME%" (
    rmdir /s /q "%WEBAPPS%\%APP_NAME%"
    echo      Removed exploded folder: %APP_NAME%
)
if exist "%WEBAPPS%\%WAR_NAME%" (
    del /q "%WEBAPPS%\%WAR_NAME%"
    echo      Removed old WAR file
)
echo.

REM Step 4: Copy new WAR
echo [4/4] Deploying new WAR...
copy /y "target\%WAR_NAME%" "%WEBAPPS%\" >NUL
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to copy WAR file!
    exit /b 1
)
echo      Deployed: %WEBAPPS%\%WAR_NAME%
echo.

echo ============================================
echo Deployment complete!
echo ============================================
echo.
echo To start Tomcat, run:
echo   %TOMCAT_HOME%\bin\startup.bat
echo.
echo Or use: scripts\start-tomcat-war.bat
echo.
echo Application URL: http://localhost:8080/%APP_NAME%
echo ============================================

endlocal
