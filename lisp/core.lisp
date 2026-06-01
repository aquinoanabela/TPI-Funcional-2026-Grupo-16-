;;======================================== 
;; REQUERIMIENTO 1: Estados de Transición 
;; NATURALEZA: Pura 
;; ESTRATEGIA: Evaluación de Patrones / Condicional Estricto 
;; IMPACTO EN MEMORIA: No destructiva (Retorna una lista nueva) 
;;========================================

(defun transicion(color-actual cambiar-a) ;; Cambiar y hacer la validacion del ciclo Verde-amarillo amarillo-rojo  rojo-verde (hacer validacion inversa)
    (let ((colores_incluidos (list 'en-rojo 'en-amarillo 'en-verde))(colores_cambio (list 'rojo 'amarillo 'verde)))
        (cond 
            ((not (member color-actual colores_incluidos)) nil) ;;Agregamos funcion para verificar que el color-actual este en los permitidos
            ((and (eql 'en-verde color-actual)(eql 'amarillo cambiar-a)(list color-actual 'cambiar-a-amarillo)))
            ((and (eql 'en-amarillo color-actual)(eql 'rojo cambiar-a)(list color-actual 'cambiar-a-rojo)))
            ((and (eql 'en-rojo color-actual)(eql 'verde cambiar-a)(list color-actual 'cambiar-a-verde))) ;;La funcion member devolveria NIL en caso de que no se encuentre en la lista definida
            (t (list color-actual 'accion-por-defecto)) ;; Ver donde se verifica el dato si aca o en alguna entrada
                                                        ;; primer error no verificar el dato antes de devolver color-actual
        )
    )
)
