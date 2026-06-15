(load "C:/Users/Fernanda/quicklisp/setup.lisp") ; para poder ejecutar de momento sino no me funciona
(ql:quickload "local-time") ;librería local-time 

;;REQUERIMIENTO 3: Sistema de Auditoría Y FASE 2 : Autonomia y Ecosistema
;; ========================================================
;; FUNCIÓN: sistema-auditoria
;; NATURALEZA: Impura (escribe un archivo)
;; ESTRATEGIA: Persistencia de datos
;; IMPACTO: Destructiva (modifica un archivo externo)
;; ========================================================

(defun sistema-auditoria () ; no recibe parametros ya que usamos para escribir en el archivo
   (let* (
          (tiempo-actual (- (get-universal-time) 2208988800)); get-universal-time cuenta segundos desde 01/01/1900 y se resta 2208988800s (diferencia entre 1900 y 1970) 
                                                            ; para obtener un nro compatible con la funcion timer
          (color-nuevo (timer_con_intermitencia tiempo-actual))

          (color-anterior
             (cond
                ((eql color-nuevo 'verde) 'rojo-intermitente)
                ((eql color-nuevo 'rojo-intermitente) 'rojo)
                ((eql color-nuevo 'rojo) 'amarillo-intermitente)
                ((eql color-nuevo 'amarillo-intermitente) 'amarillo)
                ((eql color-nuevo 'verde-intermitente) 'verde)
                (t 'verde-intermitente)
             )
          )
      )

      (with-open-file (stream
                       "informe-ejecucion-semaforo.txt" ;nombre del archivo
                       :direction :output ; "output" abre el archivo para escribir
                       :if-exists :append ; para que agregue nuevas lineas y que no sobreescriba las anteriores
                       :if-does-not-exist :create ;si no existe el archivo lo crea
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
;; decidimos crear esta fncion para que sea mas reutilizable a la hora de formatear la fecha asi la fn "sistema-auditoria" no quedaba tan extensa
(defun obtener-fecha-formateada()
   (local-time:format-timestring ; transforma una fecha o hora en un string
      nil; eso hace que no imprima sino que devuelva un string al igual que se usa format nil
      (local-time:now); la fecha actual UTC (Zona Horaria Universal)
      :format '( (:year 4) ; para el año 4d por 2026
                  "-"
                  (:month 2); 2d para mes
                  "-"
                  (:day 2) ;2d para dia
                  " " 
                  (:hour 2) ;horas
                  ":"
                  (:min 2) ;min
                  ":"
                  (:sec 2);seg

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
