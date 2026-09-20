# TerminalFix - Configuración Wi-Fi Estudiantes

Herramienta en Batch para **Windows 10** desarrollada por **TerminalFix** para automatizar la configuración de conectividad Wi-Fi en netbooks escolares.

El script permite configurar automáticamente una red inalámbrica institucional, establecer los parámetros de seguridad, restringir la conexión a otras redes Wi-Fi y configurar servidores DNS.

## Características

* Detección automática del adaptador Wi-Fi.
* Creación automática del perfil inalámbrico.
* Configuración de red **WPA2-PSK / AES**.
* Conexión automática a la red configurada.
* Bloqueo de otras redes Wi-Fi mediante filtros de `netsh wlan`.
* Configuración de servidores DNS personalizados.
* Configuración automática de DNS primario y secundario.
* Verificación de los filtros Wi-Fi configurados.
* Visualización de la configuración DNS al finalizar.
* No requiere instalar software adicional.

## Requisitos

* Windows 10.
* Privilegios de administrador.
* Acceso a la red inalámbrica que se desea configurar.

## Configuración

Los principales parámetros se encuentran al comienzo del archivo `.bat`:

```bat
set "SSID=Estudiantes"
set "PASSWORD=XXXXXXXXXX"

set "DNS1=185.228.168.168"
set "DNS2=185.228.169.168"
```

Los valores incluidos corresponden a una **configuración de referencia utilizada durante las pruebas de implementación**.

Pueden modificarse según la infraestructura de red donde se utilice el script.

### Parámetros personalizables

| Parámetro  | Ejemplo           | Descripción                             |
| ---------- | ----------------- | --------------------------------------- |
| `SSID`     | `Estudiantes`     | Nombre de la red Wi-Fi que se permitirá |
| `PASSWORD` | `XXXXXXXXXX`      | Contraseña de la red inalámbrica        |
| `DNS1`     | `185.228.168.168` | Servidor DNS primario                   |
| `DNS2`     | `185.228.169.168` | Servidor DNS secundario                 |

Por lo tanto, la red **`Estudiantes`**, la contraseña y los servidores DNS utilizados en esta implementación **no son valores obligatorios del script** y pueden reemplazarse por los correspondientes a otra institución o infraestructura.

### Red Wi-Fi utilizada durante las pruebas

La implementación de referencia utilizó:

```text
SSID:       Estudiantes
Seguridad:  WPA2-PSK
Cifrado:    AES
```

Estos parámetros pueden modificarse según la configuración de la red inalámbrica utilizada.

### DNS utilizado durante las pruebas

Durante las pruebas se utilizaron los servidores DNS de **CleanBrowsing Family Filter**:

```text
DNS primario:   185.228.168.168
DNS secundario: 185.228.169.168
```

La utilización de estos servidores corresponde únicamente a la configuración adoptada para esta implementación.

El script permite utilizar otros servidores DNS modificando los valores correspondientes.

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

Se configura un filtro para permitir la red definida en el parámetro `SSID` y se establece una política de bloqueo para las demás redes Wi-Fi.

Por ejemplo:

```text
Estudiantes
```

Cuando se utiliza el filtro:

```text
denyall
```

Windows impedirá la conexión a otras redes Wi-Fi que no estén autorizadas mediante los filtros configurados.

### 5. Configuración DNS

El adaptador inalámbrico se configura con los servidores DNS definidos mediante:

```bat
set "DNS1=..."
set "DNS2=..."
```

### 6. Conexión

Finalmente, el script intenta conectar automáticamente la netbook a la red inalámbrica configurada.

### 7. Verificación

Al finalizar muestra:

* Adaptador Wi-Fi utilizado.
* Red configurada.
* Servidores DNS.
* Filtros Wi-Fi configurados.

## Ejecución

1. Descargar o copiar el archivo:

```text
Configuracion-WiFi-Estudiantes.bat
```

2. Editar los parámetros de configuración si es necesario.

3. Hacer clic derecho sobre el archivo.

4. Seleccionar:

```text
Ejecutar como administrador
```

5. Esperar a que finalice el proceso.

6. Verificar el resultado mostrado en pantalla.

## Importante

El script modifica la configuración de red inalámbrica del equipo.

Al utilizar el filtro:

```text
denyall
```

Windows impedirá la conexión a otras redes Wi-Fi que no estén autorizadas mediante los filtros configurados.

Si se necesita utilizar otra red inalámbrica, será necesario modificar o eliminar los filtros correspondientes.

Antes de utilizar esta función en una implementación masiva, se recomienda comprobar que la política de filtrado sea adecuada para el entorno donde se desplegará.

## Contraseña de la red

La contraseña de la red Wi-Fi se encuentra definida dentro del archivo `.bat`.

Si el repositorio es público, **no se recomienda publicar credenciales reales de una red institucional**.

Antes de distribuir el script, verificar que la contraseña incluida corresponda a una credencial destinada específicamente para este tipo de implementación.

## Compatibilidad

La herramienta fue desarrollada para **netbooks escolares con Windows 10**.

La implementación utiliza herramientas nativas de Windows, principalmente:

* Batch.
* PowerShell.
* `netsh wlan`.
* `netsh interface`.

### Validación

El script se encuentra en **etapa de pruebas y validación**.

Como parte de la validación, fue probado en **20 netbooks escolares con Windows 10**, obteniendo un funcionamiento correcto durante la implementación realizada.

Las pruebas incluyeron:

* Detección del adaptador Wi-Fi.
* Creación y configuración del perfil inalámbrico.
* Conexión a la red configurada.
* Restricción de otras redes Wi-Fi.
* Configuración de servidores DNS.
* Verificación de los filtros inalámbricos.
* Comprobación de la configuración final.

Los resultados corresponden a los equipos y condiciones utilizados durante estas pruebas.

**No se garantiza el mismo comportamiento en todos los modelos de netbooks, adaptadores Wi-Fi, controladores o configuraciones de Windows.**

Se recomienda realizar pruebas en equipos de laboratorio antes de realizar una implementación masiva.

## Uso previsto

Pensado para facilitar la configuración masiva de **netbooks escolares**, reduciendo la intervención manual del personal técnico durante la preparación de los equipos.

Especialmente útil para implementaciones donde varios equipos deben utilizar una misma red inalámbrica institucional.

Los parámetros de red deben ser adaptados a la infraestructura correspondiente antes de su utilización.

## Notas

> **Nota 1:** La red Wi-Fi `Estudiantes`, la contraseña y los servidores DNS incluidos como ejemplo corresponden a la configuración utilizada durante las pruebas y pueden ser reemplazados por otros valores.

> **Nota 2:** Los valores de configuración no deben interpretarse como requisitos universales de la herramienta.

> **Nota 3:** Antes de implementar el script en una gran cantidad de equipos, se recomienda realizar una prueba piloto y verificar la configuración de red institucional.

> **Nota 4:** Si el repositorio es público, no incluir contraseñas ni otras credenciales reales de redes institucionales.

## Estado del proyecto

**Estado:** En pruebas y validación.

La herramienta fue validada inicialmente en **20 netbooks escolares con Windows 10**. Se podrán incorporar nuevas pruebas y ajustes a medida que se utilice en diferentes equipos y configuraciones de red.

## Autor

**TerminalFix**

Herramientas, scripts y configuraciones orientadas a soporte técnico, infraestructura, sistemas y educación digital.
