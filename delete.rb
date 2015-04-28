require 'yaml'
require 'aws-sdk-core'

settings = YAML.load(File.open('settings.yml'))

Aws.config.update({
                      region: settings['s3_region'],
                      credentials: Aws::Credentials.new(settings['aws_access_key_id'], settings['aws_secret_access_key']),
                  })

s3 = Aws::S3::Client.new

files = Dir["tmp/*"]

files.each do |file|
  p file
  key = file.sub(/tmp\//, '').gsub(/__/, '/')
  s3.delete_object(
      bucket: settings['s3_bucket_name'],
      key: key
  )
end