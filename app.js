(function(){
  var ref$, route, template, middleware, port;
  ref$ = require('duvet'), route = ref$.route, template = ref$.template, middleware = ref$.middleware;
  template.engines.html = {
    compile: curry$(function(h, args){
      return h;
    })
  };
  template.folder = 'templates';
  port = (ref$ = process.env.PORT) != null ? ref$ : 8000;
  (function(){
    this.GET('/', template.render('home'));
    this.GET('/static', middleware['static']('res'));
    this.listen(port, function(){
      return console.log("listening on " + port);
    });
  }.call(route));
  function curry$(f, args){
    return f.length > 1 ? function(){
      var params = args ? args.concat() : [];
      return params.push.apply(params, arguments) < f.length && arguments.length ?
        curry$.call(this, f, params) : f.apply(this, params);
    } : f;
  }
}).call(this);
