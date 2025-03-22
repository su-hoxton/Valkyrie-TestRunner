# Valkyrie-TestRunner

### DISCLAIMER: este no es un script oficial del ramo. Y no me responsabilizo por ningún tipo de daño o pérdida en la que se pueda incurrir mediante su uso.

## 1. Setup
### 1.1 Directorio del script 
Primero descarga el script con su archivo .config, y ubica ambos donde se encuentra el ```Makefile``` de tu repositorio. En mi caso el directorio se ve de la siguiente forma:

```
-- src
-- Tests
    |-- cardjitsu
    |-- puffle
-- Makefile
-- input.txt
-- output.txt
-- cardjistu
-- puffle
-- valkyrie.sh
-- valkyrie.config
```

### 1.2 Archivos necesarios  
- Asegurate que la carpeta con los tests se encuentra en este mismo directorio, o bien especifica su path en `valkyrie.config`
-  Asegurate de tener un archivo de output para que el script pueda guardar sus resultados. En mi caso lo ingresé como `output.txt` pero puedes ocupar el que prefieras siempre y cuando lo indiques en el archivo de configuración.  

### 1.3 Permisos de ejecución
Luego para darle permiso de ejecución al script corre el siguiente comando:
```bash
chmod +x valkyrie.sh
```

## 2. How to run

### 2.1 Archivo de configuración 
Recuerda ajustar el archivo `valkyrie.config` con los siguientes parámetros
```config
EXEC
TESTS_FOLDER
```

### 2.2 Run tests
Para correr los tests utiliza el siguiente comando
```bash
./valkyrie.sh
```
