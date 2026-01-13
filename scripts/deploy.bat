@echo off
echo Building project...
call mvn clean package -DskipTests -q
if %ERRORLEVEL% NEQ 0 (
    echo Build FAILED!
    exit /b 1
)
echo Deploying WAR...
copy /Y target\PetVaccine.war "E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113\webapps\" >nul
echo Deploy SUCCESS!
