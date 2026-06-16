(* ======================================== 
   REQUERIMIENTO 1: Estados de Transición 
   NATURALEZA: Pura 
   ESTRATEGIA: Pattern Matching Estricto / Tuplas
   IMPACTO EN MEMORIA: No destructiva (Retorna una estructura Option nueva) 
   ======================================== *)
   (*en ocaml let tiene la misma utilidad que defun*)
let transicion_con_intermitencia color_actual cambiar_a =
  (*let ... in es la variante de let para la declaracion de variables locales*)
  let colores_incluidos = ["en_rojo"; "en_amarillo"; "en_verde"; "rojo_intermitente"; "amarillo_intermitente"; "verde_intermitente"] in

  (*list.mem funciona como member, buscando en la lista el valor que se desea encontrar*)
  if List.mem color_actual colores_incluidos then
    (*equivalencia de cond en ocaml*)
    match (color_actual, cambiar_a) with
      (*Some se utiliza para entregar un valor, en este caso some esta asignando a 
      color actual el valor correspondiente*)
    | ("en_verde", "verde_intermitente") -> Some (color_actual, "cambiar-a-verde-intermitente")
    | ("verde_intermitente", "amarillo") -> Some (color_actual, "cambiar-a-amarillo")
    | ("en_amarillo", "amarillo_intermitente") -> Some (color_actual, "cambiar-a-amarillo-intermitente")
    | ("amarillo_intermitente", "rojo") -> Some (color_actual, "cambiar-a-rojo")
    | ("en_rojo", "rojo_intermitente") -> Some (color_actual, "cambiar-a-rojo-intermitente")
      (*ultimo paso del cond, si no es ninguno de los anteriores cambia por defecto*)
    | _ -> Some (color_actual, "cambio-por-defecto")
  else 
    None
;; 

(* ======================================== 
   REQUERIMIENTO 2: Temporizador automatico
   NATURALEZA: Pura 
   ESTRATEGIA: Pattern Matching con Cláusulas de Guarda (when)
   IMPACTO EN MEMORIA: No destructiva (Retorna un String nuevo) 
   ======================================= *)
let timer_con_intermitencia tiempo_unix = 
 (*en caso de ser un numero negativo*)
  if tiempo_unix < 0 then 
    "error-tiempo-invalido"
else 
  (*resto de la division, variable local*)
  let residuo = tiempo_unix mod 225 in

  (*aqui, a r se le asigna el valor del residuo, y luego se compara con los valores*)
  match residuo with
  | r when r < 90 -> "en-rojo"
  | r when r < 93 -> "rojo-intermitente"
  | r when r < 213 -> "en-verde"
  | r when r < 216 -> "verde-intermitente"
  | r when r < 222 -> "en-amarillo"
  | _              -> "amarillo-intermitente"
;; 

   
