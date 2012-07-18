class LocalNode
  constructor: (@name, @type) ->

  getInfo: (prefix) ->
    console.log prefix + " " + @type + " | " + @name
  
  validate: () ->
    console.log('+++')