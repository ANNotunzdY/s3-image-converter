require 'yaml'
require 'aws-sdk-core'

settings = YAML.load(File.open('settings.yml'))

Aws.config.update({
                      region: settings['s3_region'],
                      credentials: Aws::Credentials.new(settings['aws_access_key_id'], settings['aws_secret_access_key']),
                  })

s3 = Aws::S3::Client.new

resp = s3.list_objects(bucket: settings['s3_bucket_name'])
resp.contents.each do |object|
  file_name = "tmp/#{object.key.gsub(/\//, '__')}"
  p file_name
  File.open(file_name, "w") do |file|
    s3.get_object(bucket: settings['s3_bucket_name'], key: object.key) do |chunk|
      file.write(chunk)
    end
  end
end
