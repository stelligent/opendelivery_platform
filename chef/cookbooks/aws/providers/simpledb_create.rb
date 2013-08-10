action :create do
  new_resource = @new_resource

  SimpleDbLib::create_domain(new_resource.domain)
end
