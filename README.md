# TerminalFix - Configuración Wi-Fi Estudiantes

Herramienta en Batch para **Windows 10** desarrollada por **TerminalFix** para automatizar la configuración de conectividad Wi-Fi en netbooks escolares.

El script configura automáticamente la red institucional **`Estudiantes`**, establece los parámetros de seguridad, bloquea la conexión a otras redes inalámbricas y configura servidores DNS de filtrado.

## Características

* Detección automática del adaptador Wi-Fi.
* Creación automática del perfil inalámbrico.
* Configuración de red **WPA2-PSK / AES**.
* Conexión automática a la red `Estudiantes`.
* Bloqueo de otras redes Wi-Fi mediante filtros de `netsh wlan`.
* Configuración de DNS CleanBrowsing Family.
* Configuración automática de DNS primario y secundario.
* Verificación de los filtros Wi-Fi configurados.
* Visualización de la configuración DNS al finalizar.
* No requiere instalar software adicional.

## Requisitos

* Windows 10.
* Adaptador Wi-Fi funcional.
* PowerShell disponible.
* Privilegios de administrador.
* Acceso a la red inalámbrica `Estudiantes`.

## Configuración

Los principales parámetros se encuentran al comienzo del archivo `.bat`:

```bat
set "SSID=Estudiantes"
set "PASSWORD=XXXXXXXXXX"

set "DNS1=185.228.168.168"
set "DNS2=185.228.169.168"
```

Estos valores pueden modificarse según la infraestructura de red donde se utilice el script.

### Red Wi-Fi

**SSID:**

```text
Estudiantes
```

**Seguridad:**

```text
WPA2-PSK
AES
```

### DNS

El script utiliza:

```text
DNS primario:   185.228.168.168
DNS secundario: 185.228.169.168
```

correspondientes a **CleanBrowsing Family Filter**.

## Funcionamiento

El script realiza las siguientes operaciones:

### 1. Comprobación de privilegios

Verifica que el script haya sido ejecutado con permisos de administrador.

### 2. Detección del adaptador Wi-Fi

Busca automáticamente el adaptador inalámbrico disponible y obtiene su nombre de interfaz.

### 3. Creación del perfil Wi-Fi

Genera temporalmente un perfil XML compatible con `netsh wlan` y lo registra en Windows.

El perfil utiliza:

* WPA2-Personal.
* AES.
* Conexión automática.
* Perfil disponible para todos los usuarios del equipo.

### 4. Restricción de redes inalámbricas

Se configura un filtro para permitir la red:

```text
Estudiantes
```

y se establece una política de bloqueo para las demás redes Wi-Fi.

### 5. Configuración DNS

El adaptador inalámbrico se configura con los servidores DNS definidos en el script.

### 6. Conexión

Finalmente, el script intenta conectar automáticamente la netbook a:

```text
Estudiantes
```

### 7. Verificación

Al finalizar muestra:

* Adaptador Wi-Fi utilizado.
* Red permitida.
* Servidores DNS.
* Filtros Wi-Fi configurados.

## Ejecución

1. Descargar o copiar el archivo:

```text
Configuracion-WiFi-Estudiantes.bat
```

2. Hacer clic derecho sobre el archivo.

3. Seleccionar:

```text
Ejecutar como administrador
```

4. Esperar a que finalice el proceso.

5. Verificar el resultado mostrado en pantalla.

## Importante

El script modifica la configuración de red inalámbrica del equipo.

Al utilizar el filtro:

```text
denyall
```

Windows impedirá la conexión a otras redes Wi-Fi que no estén autorizadas mediante los filtros configurados.

Si se necesita utilizar otra red inalámbrica, será necesario modificar o eliminar los filtros correspondientes.

## Contraseña de la red

La contraseña de la red Wi-Fi se encuentra definida dentro del archivo `.bat`.

Si el repositorio es público, **no se recomienda publicar credenciales reales de una red institucional**.

Antes de distribuir el script, verificar que la contraseña incluida corresponda a una credencial destinada específicamente para este tipo de implementación.

## Compatibilidad

Esta herramienta fue desarrollada y probada en **netbooks escolares con Windows 10 y 4 GB de RAM**.

La implementación utiliza herramientas nativas de Windows, principalmente:

* Batch.
* PowerShell.
* `netsh wlan`.
* `netsh interface`.

## Uso previsto

Pensado para facilitar la configuración masiva de **netbooks escolares**, reduciendo la intervención manual del personal técnico durante la preparación de los equipos.

Especialmente útil para implementaciones donde todas las netbooks deben utilizar una misma red inalámbrica institucional.

## Autor

**TerminalFix**

Herramientas, scripts y configuraciones orientadas a soporte técnico, infraestructura, sistemas y educación digital.

---

> **Nota:** Antes de implementar el script en una gran cantidad de equipos, se recomienda realizar una prueba en un equipo de laboratorio y verificar la configuración de red institucional.
