# TPI-Funcional-2026-Grupo-16-
Repositorio para el TPI de Programación Funcional (2026) - Desarrollo en Common Lisp y análisis comparativo. Grupo [16].

;;========================================
;; REQUERIMIENTO 1: Estados de Transición
;; NATURALEZA: Pura
;; ESTRATEGIA: Evaluación de Patrones / Condicional Estricto
;; IMPACTO EN MEMORIA: No destructiva (Retorna una lista nueva)
;;========================================
defecto"))))

(defun transicion (color-actual cambiar-a)
  "Valida el cambio de luces del semáforo e incluye validación estricta de tipos y valores."
  (cond
    ;; --- CAPA DE VALIDACIÓN DE ENTRAD---
    ;; 1. Valida que color-actual sea un símbolo permitido
    (not (member color-actual '(en-rojo en-verde en-amarillo)))
    (list color-actual "accion-por-defecto"))
    
   ;; 2. Valida que cambiar-a sea un símbolo permitido
    ((not (member cambiar-a '(rojo verde amarillo)))
     (list color-actual "accion-por-defecto"))

  ;; --- MÁQUINA DE ESTADOS (TRANSICIONES VÁLIDAS) ---
    ;; De Rojo a Verde
    ((and (eq color-actual 'en-rojo) (eq cambiar-a 'verde))
     (list 'en-verde "cambiar-a-verde"))
    
  ;; De Verde a Amarillo
    ((and (eq color-actual 'en-verde) (eq cambiar-a 'amarillo))
     (list 'en-amarillo "cambiar-a-amarillo"))
    
  ;; De Amarillo a Rojo
    ((and (eq color-actual 'en-amarillo) (eq cambiar-a 'rojo))
     (list 'en-rojo "cambiar-a-rojo"))
    
   ;; Por defecto: Transición de colores incorrecta (ej. de Rojo a Amarillo directamente)
    (t 
     (list color-actual "accion-por-defecto"))))

 ;;========================================
;; REQUERIMIENTO 2: Temporizador Automático
;; NATURALEZA: Pura
;; ESTRATEGIA: Mapeo Matemático / Operación de Módulo
;; IMPACTO EN MEMORIA: No destructiva
;;========================================
(defun timer (tiempo-unix)
  "Calcula el color activo basándose en el tiempo Unix sin usar variables locales."
  (cond
    ;; Primeros 90 segundos (0 a 89) -> Rojo
    ((< (mod tiempo-unix 216) 90) 'rojo)
    
   ;; Siguientes 120 segundos (90 a 209) -> Verde
    ((< (mod tiempo-unix 216) 210) 'verde)
    
   ;; Últimos 6 segundos (210 a 215) -> Amarillo
    (t 'amarillo)))





;;========================================
;; REQUERIMIENTO 3: Sistema de Auditoría (Terminal)
;; FUNCIÓN: log-cambio-consola
;; NATURALEZA: Impura (Efecto secundario de salida en la terminal)
;; ESTRATEGIA: Operaciones de Salida…
;; IMPACTO EN MEMORIA: No destructiva
;;========================================
(defun log-cambio-consola (tiempo-unix color-actual cambiar-a)
  "Registra en la terminal el cambio de estado para análisis forense usando formato nativo."
  (format t "Tiempo: la luz ha cambiado de a 
          tiempo-unix 
          color-actual 
          cambiar-a))
