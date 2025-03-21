# Valkyrie-TestRunner
Script para correr de forma sencilla los tests del curso IIC2133

## 1. Setup
1.1 Primero descarga el script con su archivo .config, y ubica ambos donde se encuentra el ```Makefile``` de tu repositorio. En mi caso esto se ve de la siguiente forma:

[Insertar imagen]

1.2 Ubica la carpeta con los tests en el mismo directorio que el script

1.3 Luego para darle permiso de ejecución al script corre el siguiente comando:
```bash
chmod +x valkyrie.sh
```

## 2. How to run

2.1 Recuerda ajustar el archivo `valkyrie.config` con los siguientes parámetros
```config
EXEC
TESTS_FOLDER
```

2.2 Para correr los tests utiliza el siguiente comando
```bash
./valkyrie
```