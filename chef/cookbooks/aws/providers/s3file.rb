action :create do
  new_resource = @new_resource
  download = true

  if download
    S3FileLib::get_from_s3(new_resource.bucket, new_resource.key, new_resource.path)

    file new_resource.path do
      owner new_resource.owner if new_resource.owner
      group new_resource.group if new_resource.group
      mode new_resource.mode if new_resource.mode
      action :create
    end
  end
end
