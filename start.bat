@echo off
echo ========================================
echo   PetVaccine - Starting Tomcat Server
echo ========================================
echo.

echo Step 1: Stopping old Tomcat if running...
taskkill /F /IM java.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo Step 2: Setting environment...
set CATALINA_HOME=E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113
set CATALINA_BASE=%CATALINA_HOME%

echo Step 3: Starting Tomcat...
cd /d %CATALINA_HOME%\bin
call startup.bat

echo.
echo Step 4: Waiting for Tomcat to start (10 seconds)...
timeout /t 10 /nobreak >nul

echo.
echo Opening browser...
start http://localhost:8080/PetVaccine/home

echo.
echo ========================================
echo   Server started successfully!
echo   URL: http://localhost:8080/PetVaccine/home
echo ========================================
