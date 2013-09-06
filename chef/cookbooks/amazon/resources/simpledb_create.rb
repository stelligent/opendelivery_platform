actions :create

attribute :domain, :kind_of => String, :name_attribute => true
attribute :aws_access_key, :kind_of => String
attribute :aws_secret_access_key, :kind_of => String
attribute :region, :kind_of => String

def initialize(*args)
  super
  @action = :create
end
