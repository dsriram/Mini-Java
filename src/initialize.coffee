class LocalNode
  constructor: (@name, @type, @subtype) ->
    @parent = null
    @children = []
    @scope = {}
    @desc = ""

  addChild: (childNode) ->
    @children.push childNode
    return @children

  getInfo: (prefix) ->
    console.log prefix + " " + @type + " | " + @name
  
  validate: () ->
    console.log "----++++----"
    return false;