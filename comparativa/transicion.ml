
(*en ocaml let tiene la misma utilidad que defun*)
let transicion (color_actual cambiar-a)
  (*let ... in es la variante de let para la declaracion de variables locales*)
  let colores-incluidos = [en_rojo; en_amarillo; en_verde] in
  let colores-cambio = [rojo; amarillo; verde] in

  (*list.mem funciona como member, buscando en la lista el valor que se desea encontrar*)
  if list.mem color_actual colores-incluidos then
    None 
  else 
    (*equivalencia de cond en ocaml*)
    match (color_actual, cambiar-a) with
      (*Some se utiliza para entregar un valor, en este caso some esta asignando a 
      color actual el valor correspondiente*)
    | (en_verde, amarillo) => Some (color_actual, "cambiar-a-amarillo")
    | (en_amarillo, rojo) => Some (color_actual, "cambiar-a-rojo")
    | (en_rojo, verde) => Some (color_actual, "cambiar-a-verde")
      (*ultimo paso del cond, si no es ninguno de los anteriores cambia por defecto*)
    | _ => Some (color_actual, "cambio-por-defecto")
;; 
   
   