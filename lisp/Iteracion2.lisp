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