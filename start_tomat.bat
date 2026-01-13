@echo off
echo Stopping old Tomcat if running...
taskkill /F /IM java.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo Starting Tomcat...
set CATALINA_HOME=E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113
set CATALINA_BASE=%CATALINA_HOME%
cd /d %CATALINA_HOME%\bin
call startup.bat

echo.
echo Tomcat starting... Wait 10s
timeout /t 10 /nobreak >nul
start http://localhost:8080/PetVaccine/home
