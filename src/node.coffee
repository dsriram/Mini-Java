# NODE
# ==============================================================================
class LocalNode
  constructor: (@type, @subtype, @parent) ->
    @children = []
    @scope = {}
    @desc = ''
    @id = @randomID()

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

  printAbbrevJSON: ->
    if @children && @children.length
      childrenJSON = (child.printAbbrevJSON() for child in @children)
    
    return {
      'leaf': false
      @type
      childrenJSON
    }

  printJSON: ->
    if @children && @children.length
      childrenJSON = (child.printJSON() for child in @children)
    
    return {
      'leaf': false
      @id
      @type
      @subtype
      @scope
      parent: if @parent then @parent.id else 'undefined'
      childrenJSON
    }

  randomID: ->
    return Math.random().toString(36).substring(10)

  checkChildren: ->
    return true if ! (@children?.length)
    result = true
    for child in @children
      # console.log "CHECKED " + child.id
      if child.parent.id != @id
        console.log "PARENTAL ERROR: parent(#{@id}), child(id: #{child.id}, alleged-parent-id: #{child.parent.id})"
        return false
      result &&= child.checkChildren()
    return result

  
  validate: ->
    return false;





# LEAF
# ==============================================================================
class LocalLeaf extends LocalNode
  constructor: (@type, @value, @parent) ->
    @desc = "LEAF [ #{type} : #{value} ]"
    @id = @randomID()

  print: ->
    console.log @desc;

  printAbbrevJSON: ->
    return {
      'leaf': true
      @type
      @value
    }

  printJSON: ->
    return {
      'leaf': true
      @id
      @type
      @value
      parent: if @parent then @parent.id else 'undefined'
    }
  
  validate: ->
    return true;






