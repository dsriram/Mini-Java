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
    inMyScope = @scope?[variableName]
    if !inMyScope
      if @parent
        return @parent.searchForVariableInScope variableName
      else
        return {};
    return inMyScope;

  # type
  # -------------------------
  setType: (type) ->
    @type = type
    return

  resolveType: () ->
    return


  # helpers
  # -------------------------
  print: ->
    @resolveType()
    return;

  printAbbrevJSON: ->
    @resolveType()

    if @children && @children.length
      childrenJSON = (child.printAbbrevJSON() for child in @children)
    
    return {
      'leaf': false
      @rule
      childrenJSON
    }

  printJSON: ->
    @resolveType()
    if @children && @children.length
      childrenJSON = (child.printJSON() for child in @children)
    
    return {
      'leaf': false
      @id
      @rule
      @type
      @rule_number
      @scope
      'parent': if @parent then @parent.id else 'undefined'
      childrenJSON
    }

  printD3: ->
    @resolveType()
    if @children && @children.length
      childrenJSON = (child.printD3() for child in @children)
    
    obj = {
      'leaf': false
      'name': @rule
      @scope
      'children': childrenJSON
    }
    if (@type) then obj['type'] = @type
    return obj

  

  randomID: ->
    return Math.random().toString(36).substring(2,9)

  checkChildren: ->
    # console.log " CHECK   " + @id + "\t\t" + @rule
    
    return true if ! (@children?.length)
    
    result = true
    for child in @children
      # console.log "CHECKED " + child.id
      if child.parent.id != @id
        # console.log "PARENTAL ERROR: parent(#{@id}), child(id: #{child.id}, alleged-parent-id: #{child.parent.id})"
        return false
      result &&= child.checkChildren()
    return result

  validate: ->
    @resolveType()
    return @validateChildren()

  validateChildren: ->
    # console.log "VALIDATING      #{@id}  #{@rule}"
    
    return true if ! (@children?.length)
    
    for child in @children
      child.resolveType()
      res = child.validate()
      # console.log "VALIDATE CHILD  #{child.id}  #{child.rule} \t--> #{res}"
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
    @resolveType()
    console.log @desc;

  printAbbrevJSON: ->
    @resolveType()
    return {
      'leaf': true
      @rule
      @value
    }

  printJSON: ->
    @resolveType()
    return {
      'leaf': true
      @id
      @type
      @value
      'parent': if @parent then @parent.id else 'undefined'
    }

  printD3: ->
    @resolveType()
    obj = {
      'leaf': true
      'name': @value
    }
    if (@type) then obj['type'] = @type
    return obj
  
  validate: ->
    return true;






