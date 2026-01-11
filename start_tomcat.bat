@echo off
echo ========================================
echo Starting Tomcat Server...
echo ========================================

set CATALINA_HOME=E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113
set CATALINA_BASE=E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113

echo CATALINA_HOME=%CATALINA_HOME%

cd /d %CATALINA_HOME%\bin

echo.
echo Checking Java...
java -version

echo.
echo Starting Tomcat on port 8080...
call catalina.bat run
