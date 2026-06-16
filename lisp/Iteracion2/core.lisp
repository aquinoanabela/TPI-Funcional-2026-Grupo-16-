(load "C:/Users/Fernanda/quicklisp/setup.lisp") ; para poder ejecutar de momento sino no me funciona
(ql:quickload "local-time") ;librería local-time

;;======================================
; ; REQUERIMIENTO 1: Estados de Transición 
; ; NATURALEZA: Pura 
; ; ESTRATEGIA: Evaluación de Patrones / Condicional Estricto 
; ; IMPACTO EN MEMORIA: No destructiva (Retorna una lista nueva) 
;;=====================================

 (defun transicion(color-actual cambiar-a) ;; Cambiar y hacer la validacion del ciclo Verde-amarillo amarillo-rojo  rojo-verde (hacer validacion inversa)
    (let ((colores_incluidos (list 'en-rojo 'en-amarillo 'en-verde 'rojo-intermitente 'verde-intermitente 'amarillo-intermitente))
         (colores_cambio (list 'rojo 'amarillo 'verde)))
         (cond 
            ((not (member color-actual colores_incluidos)) nil) ;;Agregamos funcion para verificar que el color-actual este en los permitidos
            
            ((and (eql 'en-verde color-actual)(eql 'verde-intermitente cambiar-a)(list color-actual 'cambiar-a-verde-intermitente)))

            ((and (eql 'verde-intermitente color-actual)(eql 'amarillo cambiar-a)(list color-actual 'cambiar-a-amarillo)))

            ((and (eql 'en-amarillo color-actual)(eql 'amarillo-intermitente cambiar-a)(list color-actual 'cambiar-a-amarillo-intermitente)))

            ((and (eql 'amarillo-intermitente color-actual)(eql 'rojo cambiar-a)(list color-actual 'cambiar-a-rojo)))

            ((and (eql 'en-rojo color-actual)(eql 'rojo-intermitente cambiar-a)(list color-actual 'cambiar-a-rojo-intermitente))) ;;La funcion member devolveria NIL en caso de que no se encuentre en la lista definida

            ((and (eql 'rojo-intermitente color-actual)(eql 'verde cambiar-a)(list color-actual 'cambiar-a-verde)))

            (t (list color-actual 'accion-por-defecto)) 
        )
    )
)

;;======================================
;;REQUERIMIENTO 2: Temporizador Automático 
;; NATURALEZA: Pura 
;; ESTRATEGIA: Mapeo Matemático / Operación de Módulo 
;; IMPACTO EN MEMORIA: No destructiva 
;;======================================
(defun timer_con_intermitencia (tiempo-unix)
    "Calcula el color activo basándose en el tiempo Unix con validación de entrada."
    (cond
    ;; VALIDACIÓN: Verifica que el dato sea un número entero y no sea negativo
    ((not (and (integerp tiempo-unix) (>= tiempo-unix 0))) 'error-tiempo-invalido)

    ;; LÓGICA DEL TEMPORIZADOR (Ciclo de 216 segundos)
    ;; 1. Primeros 90 segundos (0 a 89) -> Rojo
    ((< (mod tiempo-unix 225) 90) 'en-rojo)
    ((< (mod tiempo-unix 225) 93) 'rojo-intermitente)
    
    ;; 2. Siguientes 120 segundos (91 a 215) -> Verde
    ((< (mod tiempo-unix 225) 213) 'en-verde)
    ((< (mod tiempo-unix 225) 216) 'verde-intermitente)
    
    ;; 3. Últimos 6 segundos (216 a 220) -> Amarillo
    ((< (mod tiempo-unix 225) 222) 'en-amarillo)
    (t 'amarillo-intermitente))
)



;;REQUERIMIENTO 3: Sistema de Auditoría Y FASE 2 : Autonomia y Ecosistema
;; ========================================================
;; FUNCIÓN: sistema-auditoria
;; NATURALEZA: Impura (escribe un archivo)
;; ESTRATEGIA: Persistencia de datos
;; IMPACTO: Destructiva (modifica un archivo externo)
;; ========================================================

(defun sistema-auditoria ()
   (let* (
          (tiempo-actual (- (get-universal-time) 2208988800)) 
                                                            
          (color-nuevo (timer_con_intermitencia tiempo-actual))

          (color-anterior
             (cond
                ((eql color-nuevo 'en-verde) 'rojo-intermitente)
                ((eql color-nuevo 'rojo-intermitente) 'en-rojo)
                ((eql color-nuevo 'en-rojo) 'amarillo-intermitente)
                ((eql color-nuevo 'amarillo-intermitente) 'en-amarillo)
                ((eql color-nuevo 'verde-intermitente) 'en-verde)
                (t 'verde-intermitente)
             )
          )
      )

      (with-open-file (stream
                       "informe-ejecucion-semaforo.txt" 
                       :direction :output 
                       :if-exists :append 
                       :if-does-not-exist :create 
                     )

         (format stream "[~A] la luz ha cambiado de ~A a ~A~%"
                     (obtener-fecha-formateada)
                     color-anterior
                     color-nuevo
         )
      )
   )
)
;; ========================================================
;; FUNCIÓN: obtener-fecha-formateada
;; NATURALEZA: Impura (depende del reloj del sistema)
;; ESTRATEGIA: Uso de librería externa y formateo de fecha/hora 
;; IMPACTO: No destructiva
;; ========================================================

(defun obtener-fecha-formateada()
   (local-time:format-timestring 
      nil
      (local-time:now)
      :format '( (:year 4) 
                  "-"
                  (:month 2)
                  "-"
                  (:day 2) 
                  " " 
                  (:hour 2) 
                  ":"
                  (:min 2) 
                  ":"
                  (:sec 2)

               )
   )
)


;;REQUERIMIENTO 4: Análisis de Ciclos Semafóricos
;; ========================================
;; FUNCION: duracion-del-ciclo
;; NATURALEZA: Pura
;; ESTRATEGIA: Validación de datos y cálculo aritmético
;; IMPACTO EN MEMORIA: No destructiva
;; ========================================
(defun duracion-ciclo (&optional (seg-rojo 90)(int-rojo 3)(seg-amarillo 6)(int-amarillo 3)(seg-verde 120)(int-verde 3));; &optional utiliza valores por defecto cuando llamas a la funcion sin pasarle parametros
     (if (every #'(lambda (color) ; EVERY verifica que todos los elementos de la lista cumplen una condicion(es depredicado)
                 (and (integerp color)
                      (>= color 0)))
             (list seg-rojo seg-amarillo seg-verde
                   int-rojo int-amarillo int-verde))

      (+ seg-rojo seg-amarillo seg-verde
         int-rojo int-amarillo int-verde)

      'error-tiempo-invalido)
)
;; ========================================
;; FUNCION: recomendacion-ciclo
;; NATURALEZA: Pura
;; ESTRATEGIA: Validación y clasificación por rangos
;; IMPACTO EN MEMORIA: No destructiva
;; ========================================
(defun recomendacion-ciclo (duracion)
  (cond
    ((not (integerp duracion)) 'error-tiempo-invalido); validar si es nro entero
    ((< duracion 0) 'duracion-invalida) ; por si es negativo
    ((< duracion 35) 'ciclo-demasiado-corto)
    ((and (>= duracion 35) (<= duracion 150)) 'ciclo-optimo)
    ((> duracion 150) 'ciclo-demasiado-largo)
  )
) 


;; REQUERIMIENTO 5: Planificación Temporal
;; ========================================
;; FUNCION: ciclos-por-tiempo
;; NATURALEZA: Pura
;; ESTRATEGIA: Validación, conversion de unidades (de m a s) y cálculo aritmético
;; IMPACTO EN MEMORIA: No destructiva
;; ========================================
(defun ciclos-por-tiempo (minutos) 
    (if (and (integerp minutos)(>= minutos 0))
      (nth-value 0(truncate (* minutos 60)(duracion-ciclo)));TRUNCATE devuelve dos valores: el cociente entero y el resto y con NTH-VALUE 0 para obtener solo la cantidad de ciclos completos.
        'valor-invalido                                                       
    )
)


;; REQUERIMIENTO 6: Informe de Distribución Temporal
;; ========================================================
;; FUNCIÓN: informe-distribucion-temporal
;; NATURALEZA: Pura (usamos format nil)
;; ESTRATEGIA: Composición funcional y construccion de listas
;; IMPACTO: No destructiva
;; ========================================================
(defun informe-distribucion-temporal()
    (list 'rojo (format nil "~,2f%" (porcentaje 90 (duracion-ciclo))) ;;Sacamos el let y lo cambiamos por la funcion duracion-ciclo
          'rojo-intermitente (format nil "~,2f%" (porcentaje 3 (duracion-ciclo)))
          'amarillo (format nil "~,2f%" (porcentaje 6 (duracion-ciclo))) ;; ~,2F formatea el nro con dos decimales
          'amarillo-intermitente (format nil "~,2f%" (porcentaje 3 (duracion-ciclo)))
          'verde (format nil "~,2f%" (porcentaje 120 (duracion-ciclo)))
          'verde-intermitente (format nil "~,2f%" (porcentaje 3 (duracion-ciclo)))
    )
)
;; ========================================================
;; FUNCIÓN: porcentaje
;; NATURALEZA: Pura
;; ESTRATEGIA: Validación y calculo porcentual
;; IMPACTO: No destructiva
;; ========================================================
(defun porcentaje(tiempo-color total-ciclo) ; Total del ciclo rojo 90 + 3 , amarillo 6 + 3,  verde 120 + 3 = 225 seg
    (if (and (integerp tiempo-color)(>= tiempo-color 0)(integerp total-ciclo)(>= total-ciclo 0))(* (/ tiempo-color (float total-ciclo)) 100)
        'valor-invalido
    )
)
