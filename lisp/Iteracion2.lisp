(load "C:/Users/Fernanda/quicklisp/setup.lisp") ; para poder ejecutar de momento sino no me funciona
(ql:quickload "local-time") ;librería local-time 

;; ========================================================
;; FUNCIÓN: sistema-auditoria
;; NATURALEZA: Impura (escribe un archivo)
;; ESTRATEGIA: Persistencia de datos
;; IMPACTO: Destructiva (modifica un archivo externo)
;; ========================================================


(defun sistema-auditoria ()

   (let* (
          (tiempo-actual (- (get-universal-time) 2208988800))

          (color-nuevo (timer tiempo-actual))

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

         (format stream ;para escribir en el archivo
                 "Tiempo ~A: la luz ha cambiado de ~A a ~A~%"
                 tiempo-actual
                 color-anterior
                 color-nuevo
         )
      )
   )
)

;; ========================================================
;; FUNCIÓN: obtener-fecha-formateada
;; NATURALEZA: Impura
;; ESTRATEGIA: Uso de librería externa y formateo de fecha/hora
;; IMPACTO: No destructiva
;; ========================================================

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