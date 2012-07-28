function doD3(root){
  window.m = [20, 120, 20, 120],
  window.w = 2000 - window.m[1] - window.m[3];
      window.h = 1200 - window.m[0] - window.m[2];
      window.i = 0;

  window.tree = d3.layout.tree()
      .size([window.h, window.w]);

  window.diagonal = d3.svg.diagonal()
      .projection(function(d) { return [d.y, d.x]; });

  window.vis = d3.select("#body").append("svg:svg")
      .attr("width", window.w + window.m[1] + window.m[3])
      .attr("height", window.h + window.m[0] + window.m[2])
    .append("svg:g")
      .attr("transform", "translate(" + m[3] + "," + m[0] + ")");

  window.tooltip = d3.select("body")
    .append("div")
    .attr("id", "tooltip")
    .style("position", "absolute")
    .style("z-index", "10")
    .style("window.visibility", "hidden")
    .text("a simple tooltip");    

  // d3.json("output.json", function(json) {
    window.root = root;
    window.root.x0 = window.h / 2;
    window.root.y0 = 0;


    function toggleAll(d) {
      if (d.children) {
        d.children.forEach(toggleAll);
        toggle(d);
      }
    }

    // Initialize the display to show a few nodes.
    window.root.children.forEach(toggleAll);


    update(window.root);
  // });
}
function getTooltip(d){
  var tmp="<ul>";
  tmp+="<li><h3>Name: </h3>"+d.name+"</li>";
  tmp+="<br><li><h3>Type: </h3>"+d.type+"</li>";
  tmp+="<br><li><h3>Scope:</h3>";
  tmp+="<ul>";
  for(s in d.scope){
    se = d.scope[s];
    tmp+="<li style='color:green'><u>" + s + "</u><ul>";
    tmp+="<li style='color:black'><b>Type: </b>" + se.type + "<li>";
    tmp+="<li style='color:black'><b>Kind: </b>" + se.kind + "<li>";
    tmp+="</ul></li>";
  }
  tmp+="</ul></li>";
  tmp+="</ul>";
  return tmp;

}
function update(source) {
  var duration = d3.event && d3.event.altKey ? 5000 : 500;

  // Compute the new window.tree layout.
  var nodes = window.tree.nodes(window.root).reverse();
  // Normalize for fixed-depth.
  nodes.forEach(function(d) { d.y = d.depth * 180; });

  // Update the nodes…
  var node = window.vis.selectAll("g.node")
      .data(nodes, function(d) { return d.id || (d.id = ++window.i); });

  // Enter any new nodes at the parent's previous position.
  var nodeEnter = node.enter().append("svg:g")
      .attr("class", "node")
      .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; });
      

  nodeEnter.append("svg:circle")
      .attr("r", 1e-6)
      .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; })
      .on("click", function(d) { toggle(d); update(d); });

  

  nodeEnter.append("svg:text")
      .attr("x", function(d) { return d.children || d._children ? -10 : 10; })
      .attr("dy", ".35em")
      .attr("text-anchor", function(d) { return d.children || d._children ? "end" : "start"; })
      .text(function(d) { return d.name; })
      .style("fill-opacity", 1e-6)
      .on("mouseover",function(d){return null;})
      .on("click", function(d){window.tooltip.html(getTooltip(d)); return window.tooltip.style("visibility", "visible");})
      .on("mousemove", function(){return window.tooltip.style("top", (event.pageY-10)+"px").style("left",(event.pageX+10)+"px");})
      .on("mouseout", function(){return window.tooltip.style("visibility", "hidden");});

  // Transition nodes to their new position.
  var nodeUpdate = node.transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });

  nodeUpdate.select("circle")
      .attr("r", 4.5)
      .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

  nodeUpdate.select("text")
      .style("fill-opacity", 1);

  // Transition exiting nodes to the parent's new position.
  var nodeExit = node.exit().transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
      .remove();

  nodeExit.select("circle")
      .attr("r", 1e-6);

  nodeExit.select("text")
      .style("fill-opacity", 1e-6);

  // Update the links…
  var link = window.vis.selectAll("path.link")
      .data(window.tree.links(nodes), function(d) { return d.target.id; });

  // Enter any new links at the parent's previous position.
  link.enter().insert("svg:path", "g")
      .attr("class", "link")
      .attr("d", function(d) {
        var o = {x: source.x0, y: source.y0};
        return window.diagonal({source: o, target: o});
      })
    .transition()
      .duration(duration)
      

  // Transition links to their new position.
  link.transition()
      .duration(duration)
      .attr("d", window.diagonal);

  // Transition exiting nodes to the parent's new position.
  link.exit().transition()
      .duration(duration)
      .attr("d", function(d) {
        var o = {x: source.x, y: source.y};
        return window.diagonal({source: o, target: o});
      })
      .remove();

  // Stash the old positions for transition.
  nodes.forEach(function(d) {
    d.x0 = d.x;
    d.y0 = d.y;
  });
}

// Toggle children.
function toggle(d) {
  if (d.children) {
    d._children = d.children;
    d.children = null;
  } else {
    d.children = d._children;
    d._children = null;
  }
}
