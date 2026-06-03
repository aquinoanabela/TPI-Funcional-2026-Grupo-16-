# TPI-Funcional-2026-Grupo-16-
Repositorio para el TPI de Programación Funcional (2026) - Desarrollo en Common Lisp y análisis comparativo. Grupo [16].

;; ============================================================
;; REQUERIMIENTO 2: Temporizador Automático
;; NATURALEZA: Pura
;; ESTRATEGIA: Mapeo Matemático / Operación de Módulo
;; IMPACTO EN MEMORIA: No destructiva
;; ============================================================
(defun timer (tiempo-unix)
  "Calcula el color activo basándose en el tiempo Unix con validación de entrada."
  (cond
    ;; VALIDACIÓN: Verifica que el dato sea un número entero y no sea negativo
    ((not (and (integerp tiempo-unix) (>= tiempo-unix 0)))  'error-tiempo-invalido)

    ;; LÓGICA DEL TEMPORIZADOR (Ciclo de 216 segundos)
    ;; 1. Primeros 90 segundos (0 a 89) -> Rojo
    ((< (mod tiempo-unix 216) 90) 'rojo)
    
    ;; 2. Siguientes 120 segundos (90 a 209) -> Verde
    ((< (mod tiempo-unix 216) 210) 'verde)
    
    ;; 3. Últimos 6 segundos (210 a 215) -> Amarillo
    (t 'amarillo)))

;; ============================================================
;; REQUERIMIENTO 3: Sistema de Auditoría (Terminal)
;; FUNCIÓN: log-cambio-consola
;; NATURALEZA: Impura (Efecto secundario de salida en la terminal)
;; ESTRATEGIA: Operaciones de Salida…
;; IMPACTO EN MEMORIA: No destructiva
;; ============================================================
(defun sistema_auditoria(tiempo)
    (let* ((color-nuevo (timer tiempo))
        (color-anterior  (cond   
                        ((eql color-nuevo 'verde) 'rojo)
                        ((eql color-nuevo 'amarillo) 'verde)
                        (t 'amarillo)
                    )
        ))
        (format nil "Tiempo ~A: la luz ha cambiado de ~A a ~A" tiempo color-anterior color-nuevo)
    )
)
