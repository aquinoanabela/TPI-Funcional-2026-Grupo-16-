;; ========================================================
;; FUNCIÓN: porcentaje
;; NATURALEZA: Pura
;; ESTRATEGIA: Calculo aritmetico 
;; IMPACTO: No destructiva
;; ========================================================

(defun porcentaje(tiempo-color total-ciclo) ; Total del ciclo rojo 90 + amarillo 6 + verde 120 = 216 seg
    (float(* (/ tiempo-color total-ciclo) 100))
)

;; ========================================================
;; FUNCIÓN: informe-distribucion-temporal
;; NATURALEZA: Pura
;; ESTRATEGIA: Composicion funcional
;; IMPACTO: No destructiva
;; ========================================================
(defun informe-distribucion-temporal()
    (list 'rojo (porcentaje 90 216)
            'amarillo (porcentaje 6 216)
            'verde (porcentaje 120 216)
        )
)

