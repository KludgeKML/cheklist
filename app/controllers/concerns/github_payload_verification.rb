module GithubPayloadVerification

  def verify_signature
    return setup_local_failure unless local_secret
    return setup_remote_failure unless remote_signature
    request.body.rewind
    payload_body = request.body.read
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new('sha1'),
      local_secret,
      payload_body
    )
    return verify_failure unless Rack::Utils.secure_compare(signature, remote_signature)
  end

  def local_secret
    Rails.application.config.github_webhook_secret
  end

  def remote_signature
    request.env['HTTP_X_HUB_SIGNATURE']
  end

  def setup_local_failure
    render(json: { error: "GITHUB_WEBHOOK_SECRET not set in ChekBlok!" }, status: :unauthorized)
  end

  def setup_remote_failure
    render(json: { error: "Webhook secret not set in GitHub!" }, status: :unauthorized)
  end

  def verify_failure
    render(json: { error: "Signatures didn't match!" }, status: :unauthorized)
  end
end
