# Laboratorio Post-Contenido 1 - Unidad 4
**Estudiante:** Obed Ayala 
**Materia:** Arquitectura de Computadores - UFPS

## Descripción
Este programa demuestra el uso de directivas de sección (`segment`), definición de variables de distintos tamaños (`db`, `dw`, `dd`) y el manejo de bucles (`loop`) para recorrer una tabla de datos en un entorno DOS de 16 bits.

## Requisitos
- DOSBox 0.74-3
- NASM (Ensamblador)
- ALINK (Enlazador)

## Instrucciones de Compilación
Para generar el ejecutable, se utilizaron los siguientes comandos:
1. `nasm -f obj programa.asm -o programa.obj`
2. `alink programa.obj -oEXE -o programa.exe -entry main`

## Resultado Esperado
El programa muestra un encabezado, convierte un valor numérico a ASCII ('Z') y recorre una tabla de 5 elementos imprimiendo los números del 1 al 5.
