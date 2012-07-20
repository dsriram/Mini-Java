# NODE
# ==============================================================================
class LocalNode
  constructor: (@rule, @rule_number, @parent) ->
    @children = []
    @scope = {}
    @desc = ''
    @type = 'undefined'
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
  addVariableToScope: (variableName, type, kind) ->
    if @parent
      @parent.addVariableToScope variableName, type, kind
    return;

  searchForVariableInScope: (variableName) ->

    return;

  # type
  # -------------------------
  setType: (type) ->
    @type = type


  # helpers
  # -------------------------
  print: ->
    return;

  printAbbrevJSON: ->
    if @children && @children.length
      childrenJSON = (child.printAbbrevJSON() for child in @children)
    
    return {
      'leaf': false
      @rule
      childrenJSON
    }

  printJSON: ->
    if @children && @children.length
      childrenJSON = (child.printJSON() for child in @children)
    
    return {
      'leaf': false
      @id
      @rule
      @type
      @rule_number
      @scope
      parent: if @parent then @parent.id else 'undefined'
      childrenJSON
    }

  randomID: ->
    return Math.random().toString(36).substring(2,9)

  checkChildren: ->
    # console.log " CHECK   " + @id + "\t\t" + @rule
    
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
    return @validateChildren()

  validateChildren: ->
    console.log "VALIDATING      #{@id}  #{@rule}"
    
    return true if ! (@children?.length)
    
    for child in @children
      res = child.validate()
      console.log "VALIDATE CHILD  #{child.id}  #{child.rule} \t--> #{res}"
      return false if !res
    return true





# LEAF
# ==============================================================================
class LocalLeaf extends LocalNode
  constructor: (@rule, @value, @parent) ->
    @desc = "LEAF [ #{rule} : #{value} ]"
    # @type = @rule
    @id = @randomID()

  print: ->
    console.log @desc;

  printAbbrevJSON: ->
    return {
      'leaf': true
      @rule
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






