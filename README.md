# TPI-Funcional-2026-Grupo-16-
# 🚦 Sistema Inteligente de Semáforos

## Integrantes del Grupo

| Integrante | Usuario GitHub |
|------------|----------------|
| Arredondo Vera Araceli Estefany | Nayuu-vv |
| Del Valle Aquino Anabela | aquinoanabela |
| Galarza Juan Pablo | jpgala12-gif |
| Gonzalez Oviedo Bruno Fabricio | FabricioGonzalez99 |
| Quiñones Fernanda | fernandaeq / ferr-eq |

## Descripción

Trabajo Práctico Integrador de Paradigmas y Lenguajes de Programación.

El proyecto implementa un Sistema Inteligente de Semáforos utilizando Common Lisp, aplicando conceptos de programación funcional como funciones puras, composición funcional, inmutabilidad y funciones de orden superior.

Además, se integra la librería `local-time` mediante Quicklisp para mejorar el sistema de auditoría y se realiza una comparación con el lenguaje OCaml.

---

## Requisitos

- CLISP
- Quicklisp
- Librería local-time

## Herramientas utilizadas durante el desarrollo

- Sublime Text
- Visual Studio Code
- Git
- GitHub
- Git Bash

---

## Instalación y ejecución

### 1. Cargar Quicklisp

```lisp
(load "~/quicklisp/setup.lisp")
```

### 2. Cargar la librería requerida

```lisp
(ql:quickload "local-time")
```

### 3. Cargar el archivo principal del proyecto

```lisp
(load "lisp/iteracion2/core.lisp")
```
**Importante:** la librería `local-time` debe cargarse antes de ejecutar `lisp/iteracion2/core.lisp`, ya que el proyecto utiliza las funciones `local-time:now` y `local-time:format-timestring` para generar fechas legibles en el sistema de auditoría.

---

## Funcionalidades implementadas

### Requerimiento 1

Estados de transición del semáforo.

### Requerimiento 2

Temporizador automático con intermitencias.

### Requerimiento 3

Sistema de auditoría con registro en archivo.

### Requerimiento 4

Análisis de ciclos semafóricos.

### Requerimiento 5

Planificación temporal.

### Requerimiento 6

Informe de distribución temporal.

---

## Ejemplos de uso

```lisp
(transicion 'en-rojo 'rojo-intermitente)

(timer_con_intermitencia 100)

(duracion-ciclo)

(recomendacion-ciclo 225)

(ciclos-por-tiempo 60)

(informe-distribucion-temporal)

(sistema-auditoria)
```
`La versión final y recomendada para la evaluación es la ubicada en lisp/Iteracion2/core.lisp, ya que incluye las funcionalidades completas de intermitencia y la integración de local-time.`

---

## Estructura del repositorio

* `lisp/Iteracion1/core.lisp` → implementación inicial del sistema de semáforos.

* `lisp/Iteracion2/core.lisp` → versión extendida con intermitencias y la integración de la librería local-time mediante Quicklisp.

* `comparativa/solucion.ml` → implementación comparativa en OCaml correspondiente a la Fase 3.

* `docs/INFORME.pdf` → informe técnico analítico del proyecto.

* `docs/HONOR.md` → declaración de código de honor.

* `README.md` → documentación general del proyecto.

---

## Video de defensa

Enlace al video de demostración: (Agregar URL de YouTube)

---



