# NODE
# ==============================================================================
class LocalNode
  constructor: (@type, @subtype, @parent) ->
    @children = []
    @scope = {}
    @desc = ""

  # children
  # -------------------------
  addChild: (childNode) ->
    @children.push childNode
    return @children
  
  setChildren: (childNodes) ->
    @children = childNodes
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





# LEAF
# ==============================================================================
class LocalLeaf extends LocalNode
  constructor: (@type, @value, @parent) ->
    @desc = "LEAF [" + type + " : " + value + "]"

  print: ->
    console.log @desc;
  
  validate: ->
    return true;








