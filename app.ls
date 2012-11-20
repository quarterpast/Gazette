{route,template,middleware,{sync}:magic} = require \duvet
{parser,uglify} = require \uglify-js
require! {LiveScript,fs,path,stylus,nib}

template.base = \base
template.engines.html = require \handlebars
template.folder = \templates
port = process.env.PORT ? 8000

let @ = new route
	@GET '/' template.render \home
	@GET '/static/' middleware.static \res

	@GET "/subscriptions" template.render \dash
	@GET "/subscriptions/:id" template.render \dash

	@GET '/compiled/app.min.js' ->let @ = do require \browserify
		@register \ls LiveScript.compile _,{+bare}
		@add-entry "client/main.ls"

		@bundle!
		|> parser.parse
		|> uglify.ast_mangle
		|> uglify.gen_code

	@GET '/compiled/style.css' ->
		fs.read-file.sync null "stylus/main.styl" \utf8
		|> stylus
		|> (.set \compress yes)
		|> (.set \filename "stylus/main.styl")
		|> (.use nib!)
		|> (.import \nib)
		|> (.render.sync it)


	@listen port, ->console.log "listening on #port"
