open Types
open Aws
type input = CreateDBClusterParameterGroupMessage.t
type output = CreateDBClusterParameterGroupResult.t
type error = Errors_internal.t
let service = "rds"
let signature_version = Request.V4
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         (Aws.Util.of_option_exn (Endpoints.url_of service region)))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["CreateDBClusterParameterGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateDBClusterParameterGroupMessage.to_query req))))) in
  (`POST, uri, [])
let of_http body =
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "CreateDBClusterParameterGroupResponse" (snd xml))
        (Xml.member "CreateDBClusterParameterGroupResult") in
    try
      Util.or_error
        (Util.option_bind resp CreateDBClusterParameterGroupResult.parse)
        (let open Error in
           BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateDBClusterParameterGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateDBClusterParameterGroupResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      `Error
        (let open Error in
           BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some var ->
      if
        (List.mem var errors) &&
          ((match Errors_internal.to_http_code var with
            | Some var -> var = code
            | None -> true))
      then Some var
      else None
  | None -> None