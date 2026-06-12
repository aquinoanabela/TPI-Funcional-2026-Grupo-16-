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
);;No verificamos si cambiar-a entra un valor correcto, pues si no simplemente devuelve accion-por-defecto

;;============================================================
;; REQUERIMIENTO 2: Temporizador Automático
;; NATURALEZA: Pura
;; ESTRATEGIA: Mapeo Matemático / Operación de Módulo
;; IMPACTO EN MEMORIA: No destructiva
;; ============================================================
(defun timer (tiempo-unix)
    "Calcula el color activo basándose en el tiempo Unix con validación de entrada."
    (cond
    ;; VALIDACIÓN: Verifica que el dato sea un número entero y no sea negativo
    ((not (and (integerp tiempo-unix) (>= tiempo-unix 0)))  'error-tiempo-invalido)

    ;; LÓGICA DEL TEMPORIZADOR (Ciclo de 216 segundos)
    ;; 1. Primeros 90 segundos (0 a 89) -> Rojo
    ((< (mod tiempo-unix 216) 90) 'en-rojo)

    ;; 2. Siguientes 120 segundos (90 a 209) -> Verde
    ((< (mod tiempo-unix 216) 210) 'en-verde)

    ;; 3. Últimos 6 segundos (210 a 215) -> Amarillo
    (t 'en-amarillo))
)


;;======================================== 
;; REQUERIMIENTO 3: Sistemas de auditoria terminal 
;; NATURALEZA: Impura (Efecto secundario de salida en la terminal)
;; ESTRATEGIA: Operaciones de salida
;; IMPACTO EN MEMORIA: No destructiva 
;;========================================
(defun sistema_auditoria()
    (let* ((color-nuevo (timer (- (get-universal-time) 2208988800))) ;;Se pasa por parametro el tiempo actual en segundos
        (color-anterior (cond   
                            ((eql color-nuevo 'en-verde) 'rojo)
                            ((eql color-nuevo 'en-amarillo) 'verde)
                            (t 'amarillo) 
                        )
        ))
        (format nil "Tiempo ~A: la luz ha cambiado de ~A a ~A" (- (get-universal-time) 2208988800) color-anterior color-nuevo)
    )
)

;; (- (get-universal-time) 2208988800) que mide los segundos desde el 1 de enero de 1900  para calcular el tiempo Unix se le resta ese numero fijo de segundos

