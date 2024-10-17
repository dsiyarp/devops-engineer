
# Instructivo para la instalación y configuración de Apache

## Repositorio y ubicación del script
- Repositorio: [https://github.com/dsiyarp/devops-engineer.git](https://github.com/dsiyarp/devops-engineer.git)
- Ruta del script: `Fase 1/Modulo 4/setup_web_server.sh`

## Paso 1: Clonar el repositorio

1. Clona el repositorio para obtener el script.
   ```bash
   git clone https://github.com/dsiyarp/devops-engineer.git
   ```

2. Entra al directorio del repositorio:
   ```bash
   cd devops-engineer/Fase\ 1/Modulo\ 4/
   ```

## Paso 2: Dar permisos de ejecución al script

Ejecuta el siguiente comando para hacer que el script sea ejecutable:

```bash
chmod +x setup_web_server.sh
```

## Paso 3: Ejecutar el script

1. Ejecuta el script con permisos de administrador:

   ```bash
   sudo ./setup_web_server.sh
   ```

2. El script realizará las siguientes acciones automáticamente:
   - Detectará la distribución de Linux.
   - Identificará el gestor de paquetes.
   - Actualizará y mejorará el sistema.
   - Instalará el servidor Apache.
   - Personalizará el archivo `index.html` con el contenido especificado.
   - Reiniciará Apache para aplicar los cambios.

## Paso 4: Verificación

1. Abre un navegador web y ve a `http://localhost` para comprobar que el servidor Apache esté mostrando la página personalizada.
2. La página debería tener el siguiente contenido:

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Bootcamp DevOps</title>
   </head>
   <body>
   <h1>Bootcamp DevOps Engineer</h1>
   </body>
   </html>
   ```
