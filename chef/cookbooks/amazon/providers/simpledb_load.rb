action :set do
  new_resource = @new_resource
  SimpleDbLib::load_domain(new_resource.domain,  new_resource.json_file, new_resource.aws_access_key, new_resource.aws_secret_access_key, new_resource.region)
end
