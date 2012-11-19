{route,template,middleware} = require \duvet
{parser,uglify} = require \uglify-js
require! LiveScript

template.base = \base
template.engines.html = require \handlebars
template.folder = \templates
port = process.env.PORT ? 8000

let @ = new route
	@GET '/' template.render \home
	@GET '/static' middleware.static \res

	@GET '/compiled/app.min.js' ->let @ = do require \browserify
		@register \ls LiveScript.compile _,{+bare}
		@add-entry "client/main.ls"

		@bundle!
		|> parser.parse
		|> uglify.ast_mangle
		|> uglify.gen_code


	@listen port, ->console.log "listening on #port"
