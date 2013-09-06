actions :set

attribute :domain, :kind_of => String
attribute :json_file, :kind_of => String
attribute :aws_access_key, :kind_of => String
attribute :aws_secret_access_key, :kind_of => String
attribute :region, :kind_of => String

def initialize(*args)
  super
  @action = :set
end
