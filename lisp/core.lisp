;; ========================================================
;; FUNCIÓN: porcentaje
;; NATURALEZA: Pura
;; ESTRATEGIA: Calculo aritmetico 
;; IMPACTO: No destructiva
;; ========================================================

(defun porcentaje(tiempo-color total-ciclo) ; Total del ciclo rojo 90 + amarillo 6 + verde 120 = 216 seg
    (* (/ tiempo-color (float total-ciclo)) 100)
)

;; ========================================================
;; FUNCIÓN: informe-distribucion-temporal
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

