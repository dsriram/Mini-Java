class LocalNode
  constructor: (@type, @subtype) ->
    @parent = null
    @children = ['a']
    @scope = {}
    @desc = ""

  # children
  # -------------------------
  addChild: (childNode) ->
    @children.push childNode
    return @children
  

  # scope
  # -------------------------
  addVariableToScope: (variableName) ->

    return;

  searchForVariableInScope: (variableName) ->

    return;



  # helpers
  # -------------------------
  print: ->
    return;
  
  validate: ->
    return false;