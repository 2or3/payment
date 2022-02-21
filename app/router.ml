let () =
  Dream.run ~interface:"0.0.0.0"
  @@ Dream.logger
  @@ Dream.router [

    Dream.get "/"
      (fun _ ->
        Dream.html "Good morning, world!");

    Dream.get "/echo/:word"
      (fun request ->
        Dream.html (Dream.param request "word"));

  ]
