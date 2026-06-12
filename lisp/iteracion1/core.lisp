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

;; REQUERIMIENTO 4: Análisis de Ciclos Semafóricos

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
;; ESTRATEGIA: Condicional (comparacion de rango s)
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

;; REQUERIMIENTO 5: Planificación Temporal
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
;; REQUERIMIENTO 6: Informe de Distribución Temporal
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