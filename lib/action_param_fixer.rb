# Some webhooks pass an action parameter which gets 
# overwritten by rails. This saves the param to another
# parameter (webhook_action). To use, add:
#
# config.autoload_paths += Dir[&amp;quot;#{config.root}/lib/**/&amp;quot;]
# config.middleware.use &amp;quot;ParamsFixer&amp;quot;
#
# ..to config/application.rb
# (Source: https://status203.me/2015/02/16/rails-edge-case-solved-with-middleware/)
class ActionParamFixer
  def initialize(app)
    @app = app
  end
 
  def call(env)
    request = Rack::Request.new(env)
    if request.params['action']
      request.update_param('webhook_action', request.params['action'])
    end
    status, headers, resp = @app.call(env)
    [status, headers, resp]
  end
end