def stub_octokit
  stub_request(
    :get,
    'https://api.github.com/repos/test/test/pulls/1/files'
  ).to_return(
    status: 200,
    body: [
      { 'filename' => 'README', 'status' => 'updated' }
    ].to_json,
    headers: {
      'Content-Type' => 'application/json'
    }
  )

  stub_request(
    :get,
    'https://api.github.com/repos/test/test/pulls/2/files'
  ).to_return(
    status: 200,
    body: [
      { 'filename' => 'VERSION', 'status' => 'updated' }
    ].to_json,
    headers: {
      'Content-Type' => 'application/json'
    }
  )
end
