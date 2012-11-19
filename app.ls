{route,template,middleware} = require \duvet
hnd = require \handlebars
template.base = \base
template.engines.html = compile: (src,args)->hnd.compile src <| args
template.folder = \templates
port = process.env.PORT ? 8000

let @ = route
	@GET '/' template.render \home
	@GET '/static' middleware.static \res

	@listen port, ->console.log "listening on #port"
