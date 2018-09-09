let With =
      \(value_type : Type) ->
        { web_driver_io : value_type, docker : value_type }

let for =
      \(T : Type) ->
        let wrap_name_T
            : Type
            = forall (v : T) -> { name : Text, value : T }

        let named = \(name : Text) -> \(v : T) -> { name, value = v }

        in    { web_driver_io = named "WebDriverIO", docker = named "Docker" }
            : With wrap_name_T

in  { With, for }
