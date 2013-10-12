valuesHash = {}

@TestEnv =
  set: (key, value) ->
    valuesHash[key] = value

  get: (key) ->
    valuesHash[key]
