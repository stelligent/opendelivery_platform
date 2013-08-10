action :set do
  new_resource = @new_resource

  SimpleDbLib::set_property(new_resource.domain, new_resource.item, new_resource.property, new_resource.value)

end
