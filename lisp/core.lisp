;; ========================================
;; FUNCION: Duracion del ciclo
;; NATURALEZA: Pura
;; ESTRATEGIA: Calculo aritmetico
;; IMPACTO EN MEMORIA: No destructiva
;; ========================================

(defun duracion-ciclo (&optional (seg-rojo 90)(seg-amarillo 6)(seg-verde 120));; &optional utiliza valores por defecto cuando llamas a la funcion sin pasarle parametros
    (+ seg-rojo seg-amarillo seg-verde)                                       ;; pero dando la opcion a pasar parametros sin generar errores
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
;; NATURALEZA: Pura (usamos format nil)
;; ESTRATEGIA: Composicion funcional
;; IMPACTO: No destructiva
;; ========================================================
(defun informe-distribucion-temporal()
    (list 'rojo (format nil "~,2f%" (porcentaje 90 (duracion-ciclo))) ;; reutilizamos la funcion duracion-ciclo
          'amarillo (format nil "~,2f%" (porcentaje 6 (duracion-ciclo))) ;; con ~,2f para formatear y quede con 2 dicimales
          'verde (format nil "~,2f%" (porcentaje 120 (duracion-ciclo)))
    )
)

