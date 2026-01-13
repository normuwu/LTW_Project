@echo off
echo Stopping Tomcat...
taskkill /F /IM java.exe >nul 2>&1
echo Tomcat stopped!
