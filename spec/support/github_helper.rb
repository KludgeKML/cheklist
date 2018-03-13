
def signature_for_payload(payload, secret: Rails.application.config.github_webhook_secret)
  'sha1=' + OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new('sha1'),
      secret,
      payload.to_json
    )
end

def headers_for_data(request, data, event_type: 'pull_request')
  request.headers['X-GitHub-Event'] = event_type
  request.headers['Content-Type'] = 'application/json'
  request.headers['HTTP_X_HUB_SIGNATURE'] = signature_for_payload(data)
end
