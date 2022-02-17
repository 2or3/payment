[%%shared
open Eliom_lib
open Eliom_content
open Html.D
]

module Payment_app =
  Eliom_registration.App (
  struct
    let application_name = "payment"
    let global_data_path = None
  end)

let main_service =
  Eliom_service.create
    ~path:(Eliom_service.Path [])
    ~meth:(Eliom_service.Get Eliom_parameter.unit)
    ()

let () =
  Payment_app.register
    ~service:main_service
    (fun () () ->
       Lwt.return
         (Eliom_tools.F.html
            ~title:"payment"
            ~css:[["css";"payment.css"]]
            Html.F.(body [
              h1 [txt "Welcome from Eliom's distillery!"];
            ])))
