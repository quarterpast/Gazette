{route,template,middleware} = require \duvet
template.engines.html = compile(h,args): h
template.folder = \templates
port = process.env.PORT ? 8000

let @ = route
	@GET '/' template.render \home
	@GET '/static' middleware.static \res

	@listen port, ->console.log "listening on #port"
