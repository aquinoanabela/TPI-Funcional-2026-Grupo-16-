(*funcion que mide el tiempo de cada luz del semaforo*)
let timer_con_intermitencia tiempo_unix = 
 (*en caso de ser un numero negativo*)
  if tiempo_unix < 0 then 
    "error-tiempo-invalido"
else 
  (*resto de la division, variable local*)
  let residuo = tiempo_unix mod 225 in
  (*aqui no es necesario verificar que sea un entero, ya que de no serlo dara un error porque la estructura mod solo puese 
  utilizarse en valores enteros*)

  (*aqui, a r se le asigna el valor del residuo, y luego se compara con los valores*)
  match residuo with
  | r when r < 90 -> "en-rojo"
  | r when r < 93 -> "rojo-intermitente"
  | r when r < 213 -> "en-verde"
  | r when r < 216 -> "verde-intermitente"
  | r when r < 222 -> "en-amarillo"
  | _              -> "amarillo-intermitente"
;; 
