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
;;============================================================
(defun sistema_auditoria()
    (let* ((color-nuevo (timer (- (get-universal-time) 2208988800))) ;;Se pasa por parametro el tiempo actual en segundos
        (color-anterior  (cond   
                        ((eql color-nuevo 'verde) 'rojo)
                        ((eql color-nuevo 'amarillo) 'verde)
                        (t 'amarillo) ;;Se definen los cambios que hubo para
                    )
        ))
        (format nil "Tiempo ~A: la luz ha cambiado de ~A a ~A" (- (get-universal-time) 2208988800) color-anterior color-nuevo)
    )
)

;; (- (get-universal-time) 2208988800) que mide los segundos desde el 1 de enero de 1900  para calcular el tiempo Unix se le resta ese numero fijo de segundos.
;;============================================================
;; REQUERIMIENTO 4a, 4b: Análisis de Ciclos 
;; NATURALEZA: Pura
;; ESTRATEGIA: Composición y Cálculo Aritmético
;; IMPACTO EN MEMORIA: No destructiva
;; ============================================================

"4a. Calcula la duración total de un ciclo completo (Rojo -> Verde -> Amarillo) basado en las entradas de tiempo provistas."


(defun duracion-ciclo (&optional (seg-rojo 90)(seg-amarillo 6)(seg-verde 120));;&optional utiliza valores por defecto cuando llamas a la funcion sin pasarle parametros
    
(+ seg-rojo seg-amarillo seg-verde);; pero dando la opcion a pasar parametros sin generar errores
)

;;4b. Provee una recomendación de optimización basada en estándares de ingeniería de tráfico y la psicología del conductor (Rango óptimo: 35-150 segundos).

(defun recomendacion-ciclo (duracion)
    (cond
        ((< duracion 0) 'duracion-invalida) ; por si es negativo
        ((< duracion 35) 'ciclo-demasiado-corto)
        ((and (>= duracion 35) (<= duracion 150)) 'ciclo-optimo)
        ((> duracion 150) 'ciclo-demasiado-largo)
    )
) 

;; ============================================================
;; REQUERIMIENTO 5: Planificación Temporal
;; NATURALEZA: Pura
;; ESTRATEGIA: Cálculo aritmético/Truncamiento hacia abajo
;; IMPACTO EN MEMORIA: No destructiva
;;=================================================

(defun ciclos-por-tiempo (minutos)
    (let ((seg-rojo 90)(seg-amarillo 6)(seg-verde 120))
        (if (or ;para validar que ni uno sea negativo
            (< minutos 0)
            (< seg-rojo 0)
            (< seg-amarillo 0)
            (< seg-verde 0)
            )
            'valor-invalido ; si alguno es T es invalido 

(nth-value 0 (truncate (* minutos 60) (duracion-ciclo seg-rojo seg-amarillo seg-verde)))
            
  )
 )
)

