@echo off
echo ========================================
echo Dang khoi dong Tomcat...
echo ========================================

cd /d E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113\bin

echo Checking Java...
java -version

echo.
echo Starting Tomcat...
call startup.bat

echo.
echo ========================================
echo Tomcat dang khoi dong...
echo Vui long doi 10-15 giay
echo Sau do truy cap: http://localhost:8081/PetVaccine/home
echo ========================================
echo.
echo Nhan phim bat ky de mo trinh duyet...
pause

start http://localhost:8081/PetVaccine/home
