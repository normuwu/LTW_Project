@echo off
REM ============================================
REM Start Tomcat (for WAR deployment)
REM ============================================

set TOMCAT_HOME=E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113

echo Starting Tomcat...
call "%TOMCAT_HOME%\bin\startup.bat"

echo.
echo Tomcat starting...
echo Application URL: http://localhost:8080/PetVaccine
echo.
echo Press any key to open browser...
pause >NUL
start http://localhost:8080/PetVaccine
