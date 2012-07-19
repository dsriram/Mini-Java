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
    # childNode.parent = @
    @children.push childNode
    return @children
  
  setChildren: (childNodes) ->
    # _.each childNodes, (item)->
    #   item.parent = @
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

  printJSON: ->
    if @children && @children.length
      childrenJSON = (child.printJSON() for child in @children)
    return {
      "leaf": false
      @type
      childrenJSON
    }


  
  validate: ->
    return false;





# LEAF
# ==============================================================================
class LocalLeaf extends LocalNode
  constructor: (@type, @value, @parent) ->
    @desc = "LEAF [" + type + " : " + value + "]"

  print: ->
    console.log @desc;

  printJSON: ->
    return {
      "leaf": true
      @type
      @value
    }
  
  validate: ->
    return true;








