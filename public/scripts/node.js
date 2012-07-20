var LocalLeaf, LocalNode,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

LocalNode = (function() {

  function LocalNode(rule, rule_number, parent) {
    this.rule = rule;
    this.rule_number = rule_number;
    this.parent = parent;
    this.children = [];
    this.scope = {};
    this.desc = '';
    this.type = 'undefined';
    this.id = this.randomID();
  }

  LocalNode.prototype.addChild = function(childNode) {
    this.children.push(childNode);
    return this.children;
  };

  LocalNode.prototype.setChildren = function(childNodes) {
    this.children = childNodes;
    return this.children;
  };

  LocalNode.prototype.addVariableToScope = function(variableName, type, kind) {
    if (this.parent) this.parent.addVariableToScope(variableName, type, kind);
  };

  LocalNode.prototype.searchForVariableInScope = function(variableName) {
    var inMyScope, _ref;
    inMyScope = (_ref = this.scope) != null ? _ref[variableName] : void 0;
    if (!inMyScope) {
      if (this.parent) {
        return this.parent.searchForVariableInScope(variableName);
      } else {
        return {};
      }
    }
    return inMyScope;
  };

  LocalNode.prototype.setType = function(type) {
    this.type = type;
  };

  LocalNode.prototype.resolveType = function() {};

  LocalNode.prototype.print = function() {
    this.resolveType();
  };

  LocalNode.prototype.printAbbrevJSON = function() {
    var child, childrenJSON;
    this.resolveType();
    if (this.children && this.children.length) {
      childrenJSON = (function() {
        var _i, _len, _ref, _results;
        _ref = this.children;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          _results.push(child.printAbbrevJSON());
        }
        return _results;
      }).call(this);
    }
    return {
      'leaf': false,
      rule: this.rule,
      childrenJSON: childrenJSON
    };
  };

  LocalNode.prototype.printJSON = function() {
    var child, childrenJSON;
    this.resolveType();
    if (this.children && this.children.length) {
      childrenJSON = (function() {
        var _i, _len, _ref, _results;
        _ref = this.children;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          _results.push(child.printJSON());
        }
        return _results;
      }).call(this);
    }
    return {
      'leaf': false,
      id: this.id,
      rule: this.rule,
      type: this.type,
      rule_number: this.rule_number,
      scope: this.scope,
      'parent': this.parent ? this.parent.id : 'undefined',
      childrenJSON: childrenJSON
    };
  };

  LocalNode.prototype.printD3 = function() {
    var child, childrenJSON, obj;
    this.resolveType();
    if (this.children && this.children.length) {
      childrenJSON = (function() {
        var _i, _len, _ref, _results;
        _ref = this.children;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          _results.push(child.printD3());
        }
        return _results;
      }).call(this);
    }
    obj = {
      'leaf': false,
      'name': this.rule,
      scope: this.scope,
      'children': childrenJSON
    };
    if (this.type) obj['type'] = this.type;
    return obj;
  };

  LocalNode.prototype.randomID = function() {
    return Math.random().toString(36).substring(2, 9);
  };

  LocalNode.prototype.checkChildren = function() {
    var child, result, _i, _len, _ref, _ref2;
    if (!((_ref = this.children) != null ? _ref.length : void 0)) return true;
    result = true;
    _ref2 = this.children;
    for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
      child = _ref2[_i];
      if (child.parent.id !== this.id) return false;
      result && (result = child.checkChildren());
    }
    return result;
  };

  LocalNode.prototype.validate = function() {
    this.resolveType();
    return this.validateChildren();
  };

  LocalNode.prototype.validateChildren = function() {
    var child, res, _i, _len, _ref, _ref2;
    if (!((_ref = this.children) != null ? _ref.length : void 0)) return true;
    _ref2 = this.children;
    for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
      child = _ref2[_i];
      child.resolveType();
      res = child.validate();
      if (!res) return false;
    }
    return true;
  };

  return LocalNode;

})();

LocalLeaf = (function(_super) {

  __extends(LocalLeaf, _super);

  function LocalLeaf(rule, value, parent) {
    this.rule = rule;
    this.value = value;
    this.parent = parent;
    this.desc = "LEAF [ " + rule + " : " + value + " ]";
    this.id = this.randomID();
  }

  LocalLeaf.prototype.print = function() {
    this.resolveType();
    return console.log(this.desc);
  };

  LocalLeaf.prototype.printAbbrevJSON = function() {
    this.resolveType();
    return {
      'leaf': true,
      rule: this.rule,
      value: this.value
    };
  };

  LocalLeaf.prototype.printJSON = function() {
    this.resolveType();
    return {
      'leaf': true,
      id: this.id,
      type: this.type,
      value: this.value,
      'parent': this.parent ? this.parent.id : 'undefined'
    };
  };

  LocalLeaf.prototype.printD3 = function() {
    var obj;
    this.resolveType();
    obj = {
      'leaf': true,
      'name': this.value
    };
    if (this.type) obj['type'] = this.type;
    return obj;
  };

  LocalLeaf.prototype.validate = function() {
    return true;
  };

  return LocalLeaf;

})(LocalNode);
