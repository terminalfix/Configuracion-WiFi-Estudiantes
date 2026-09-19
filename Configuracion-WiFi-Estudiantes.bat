@echo off
setlocal EnableExtensions

title Configuracion Wi-Fi Estudiantes

echo.
echo ==========================================
echo     CONFIGURACION NETBOOK ESCOLAR
echo ==========================================
echo.

:: =========================================================
:: DATOS
:: =========================================================

set "SSID=Estudiantes"
set "PASSWORD=Escuelas_2025"

:: DNS CleanBrowsing Family
set "DNS1=185.228.168.168"
set "DNS2=185.228.169.168"

:: =========================================================
:: COMPROBAR ADMINISTRADOR
:: =========================================================

net session >nul 2>&1

if %errorlevel% NEQ 0 (
    echo.
    echo ERROR: Ejecutar como ADMINISTRADOR.
    echo.
    pause
    exit /b 1
)

:: =========================================================
:: DETECTAR ADAPTADOR INALAMBRICO
:: =========================================================

echo [1/4] Detectando adaptador Wi-Fi...
echo.

set "WIFI="

for /f "delims=" %%A in ('powershell -NoProfile -Command "(Get-NetAdapter | Where-Object {$_.PhysicalMediaType -eq 'Native 802.11'} | Select-Object -First 1 -ExpandProperty Name)"') do (
    set "WIFI=%%A"
)

if not defined WIFI (
    echo.
    echo ERROR: No se encontro un adaptador Wi-Fi.
    echo.
    echo Adaptadores detectados:
    powershell -NoProfile -Command "Get-NetAdapter | Format-Table Name,InterfaceDescription,Status,PhysicalMediaType -AutoSize"
    echo.
    pause
    exit /b 1
)

echo Adaptador Wi-Fi detectado:
echo "%WIFI%"
echo.

:: =========================================================
:: CREAR PERFIL WIFI
:: =========================================================

echo [2/4] Creando perfil Wi-Fi "%SSID%"...
echo.

set "XML=%TEMP%\wifi_estudiantes.xml"

(
echo ^<?xml version="1.0"?^>
echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^>
echo ^<name^>%SSID%^</name^>
echo ^<SSIDConfig^>
echo ^<SSID^>
echo ^<name^>%SSID%^</name^>
echo ^</SSID^>
echo ^</SSIDConfig^>
echo ^<connectionType^>ESS^</connectionType^>
echo ^<connectionMode^>auto^</connectionMode^>
echo ^<MSM^>
echo ^<security^>
echo ^<authEncryption^>
echo ^<authentication^>WPA2PSK^</authentication^>
echo ^<encryption^>AES^</encryption^>
echo ^<useOneX^>false^</useOneX^>
echo ^</authEncryption^>
echo ^<sharedKey^>
echo ^<keyType^>passPhrase^</keyType^>
echo ^<protected^>false^</protected^>
echo ^<keyMaterial^>%PASSWORD%^</keyMaterial^>
echo ^</sharedKey^>
echo ^</security^>
echo ^</MSM^>
echo ^</WLANProfile^>
) > "%XML%"

netsh wlan add profile filename="%XML%" user=all

del "%XML%" >nul 2>&1

:: =========================================================
:: PERMITIR SOLO ESTUDIANTES
:: =========================================================

echo.
echo [3/4] Bloqueando otras redes Wi-Fi...
echo.

netsh wlan delete filter permission=allow ssid="%SSID%" networktype=infrastructure >nul 2>&1

netsh wlan add filter permission=allow ssid="%SSID%" networktype=infrastructure

netsh wlan add filter permission=denyall networktype=infrastructure

:: =========================================================
:: CONFIGURAR DNS
:: =========================================================

echo.
echo [4/4] Configurando DNS...
echo.

echo Adaptador: "%WIFI%"
echo DNS primario: %DNS1%
echo DNS secundario: %DNS2%
echo.

netsh interface ipv4 set dnsservers name="%WIFI%" source=static address=%DNS1% register=primary validate=no

netsh interface ipv4 add dnsservers name="%WIFI%" address=%DNS2% index=2 validate=no

:: =========================================================
:: CONECTAR
:: =========================================================

echo.
echo Conectando a "%SSID%"...
echo.

netsh wlan connect name="%SSID%" interface="%WIFI%"

:: =========================================================
:: RESULTADO
:: =========================================================

echo.
echo ==========================================
echo       CONFIGURACION FINALIZADA
echo ==========================================
echo.

echo Wi-Fi permitido:
echo     %SSID%

echo.
echo Adaptador:
echo     %WIFI%

echo.
echo DNS:
echo     %DNS1%
echo     %DNS2%

echo.
echo ------------------------------------------
echo FILTROS WIFI
echo ------------------------------------------
netsh wlan show filters

echo.
echo ------------------------------------------
echo DNS
echo ------------------------------------------
netsh interface ipv4 show dnsservers name="%WIFI%"

echo.
pause
