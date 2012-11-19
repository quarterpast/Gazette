{route,template,middleware} = require \duvet
hnd = require \handlebars
template.base = \base
template.engines.html = hnd
template.folder = \templates
port = process.env.PORT ? 8000

let @ = new route
	@GET '/' template.render \home
	@GET '/static' middleware.static \res

	@listen port, ->console.log "listening on #port"
