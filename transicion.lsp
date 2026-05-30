
;Pura - directa - no destructiva
(defun transicion(color-actual cambiar-a)
    (let ((colores_incluidos (list 'en-rojo 'en-amarillo 'en-verde))(colores_cambio (list 'rojo 'amarillo 'verde)))
        (cond 
            ((null (member color-actual colores_incluidos)) "El valor de color actual es incorrecto") ;;Agregamos funcion para verificar que el color-actual este en los permitidos
            ((and (member cambiar-a colores_cambio)(list color-actual 'cambiar-a- cambiar-a)))  ;;La funcion member devolveria NIL en caso de que no se encuentre en la lista definida
            (t (list color-actual 'accion-por-defecto)) ;; Ver donde se verifica el dato si aca o en alguna entrada
                                                        ;; primer error no verificar el dato antes de devolver color-actual
        )
    )
)

