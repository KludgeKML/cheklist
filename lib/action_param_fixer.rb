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
    request = ActionParamFixerRequest.new(env)
    request.copy_param(from: 'action', to: 'webhook_action')
    status, headers, resp = @app.call(env)
    [status, headers, resp]
  end

  # Rack::Request subclass that supports copying params to new names
  class ActionParamFixerRequest < Rack::Request
    def copy_param(from:, to:)
      return unless params[from]
      update_param(to, params[from])
    end
  end
end