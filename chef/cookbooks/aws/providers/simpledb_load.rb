action :set do
  new_resource = @new_resource
  SimpleDbLib::load_domain(new_resource.domain,  new_resource.json_file)
end
