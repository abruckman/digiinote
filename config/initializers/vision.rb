require "google/cloud/vision"
GOOGLE_APPLICATION_CREDENTIALS = './google_application_credentials.json'
ENV['GOOGLE_APPLICATION_CREDENTIALS'] = './google_application_credentials.json'

File.open("./google_application_credentials.json", "w+") do |f| 
  f.write(ERB.new(File.read('./google_application_credentials.json.tmp')).result)
end

# Your Google Cloud Platform project ID
project_id = ENV['PROJECT_ID']
scopes =  [
  'https://www.googleapis.com/auth/cloud-platform',
  'https://www.googleapis.com/auth/compute'
]
authorization = Google::Auth.get_application_default(scopes)

# Add the the access token obtained using the authorization to a hash, e.g
# headers.
# some_headers = {}
# authorization.apply(some_headers)
# Instantiates a client
VISION = Google::Cloud::Vision.new project: project_id
