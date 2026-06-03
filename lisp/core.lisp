;; ========================================
;; FUNCION: Duracion del ciclo
;; NATURALEZA: Pura
;; ESTRATEGIA: Calculo aritmetico
;; IMPACTO EN MEMORIA: No destructiva
;; ========================================

(defun  duracion-ciclo( seg-rojo seg-amarillo seg-verde) 
 (+ seg-rojo seg-amarillo seg-verde ) ; validar aca
)

;; ========================================
;; FUNCION: Recomendacion del ciclo
;; NATURALEZA: Pura
;; ESTRATEGIA: Condicional (comparacion de rangos)
;; IMPACTO EN MEMORIA: No destructiva
;; ========================================

(defun recomendacion-ciclo (duracion)
  (cond
    ((< duracion 0) 'duracion-invalida) ; por si es negativo
    ((< duracion 35) 'ciclo-demasiado-corto)
    ((and (>= duracion 35) (<= duracion 150)) 'ciclo-optimo)
    ((> duracion 150) 'ciclo-demasiado-largo)
  )
) ;ver si la manera que muestro el msj esta bien

;; ========================================
;; FUNCION: Ciclos por tiempo
;; NATURALEZA: Pura
;; ESTRATEGIA: Composicion funcional, calculo aritmetico y validación condicional
;; IMPACTO EN MEMORIA: No destructiva
;; ========================================

(defun ciclos-por-tiempo (minutos) 
   (let ((seg-rojo 90)
         (seg-amarillo 6)
         (seg-verde 120))

      (if (< minutos 0) 'valor-invalido
          (nth-value 0(truncate (* minutos 60)(duracion-ciclo seg-rojo seg-amarillo seg-verde))) ; con nth-value 0 me quedo con el primer valor 
      )
   )
)

;; ========================================================
;; FUNCIÓN: Porcentaje
;; NATURALEZA: Pura
;; ESTRATEGIA: Calculo aritmetico 
;; IMPACTO: No destructiva
;; ========================================================

(defun porcentaje(tiempo-color total-ciclo) ; Total del ciclo rojo 90 + amarillo 6 + verde 120 = 216 seg
    (* (/ tiempo-color (float total-ciclo)) 100)
)

;; ========================================================
;; FUNCIÓN: Informe distribucion temporal
;; NATURALEZA: Pura
;; ESTRATEGIA: Composicion funcional
;; IMPACTO: No destructiva
;; ========================================================
(defun informe-distribucion-temporal()
    (let ((total-ciclo(+ 90 6 120))) ; por si mas adelante se necesita modificar la temporizacion de algun color 
    (list 'rojo (porcentaje 90 total-ciclo)
            'amarillo (porcentaje 6 total-ciclo)
            'verde (porcentaje 120 total-ciclo)
        )
    )
)

