# TPI-Funcional-2026-Grupo-16-
(* Función de timer con intermitencia en OCaml *)

(* Tipo variante para los estados del semáforo *)

type estado_semaforo =
  | EnRojo
  | RojoIntermitente
  | EnVerde
  | VerdeIntermitente
  | EnAmarillo
  | AmarilloIntermitente
  | ErrorTiempoInvalido

let timer_con_intermitencia tiempo_unix =
  
  (* Filtramos primero el error de tiempo negativo *)
  
  if tiempo_unix < 0 then 
    ErrorTiempoInvalido
  else
  
    (* Calculamos el residuo una sola vez *)
  
    let residuo = tiempo_unix mod 225 in
    
    (* Usamos match con condiciones 'when' en vez de ifs anidados *)
    match residuo with
    | r when r < 90  -> EnRojo
    | r when r < 93  -> RojoIntermitente
    | r when r < 213 -> EnVerde
    | r when r < 216 -> VerdeIntermitente
    | r when r < 222 -> EnAmarillo
    | _              -> AmarilloIntermitente (* Caso por defecto (de 222 a 224) *)
