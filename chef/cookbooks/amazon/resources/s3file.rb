actions :create

attribute :path, :kind_of => String, :name_attribute => true

attribute :key, :kind_of => String
attribute :bucket, :kind_of => String
attribute :owner, :kind_of => [String, NilClass], :default => nil
attribute :group, :kind_of => [String, NilClass], :default => nil
attribute :mode, :kind_of => [String, NilClass], :default => nil
attribute :aws_access_key, :kind_of => String
attribute :aws_secret_access_key, :kind_of => String

def initialize(*args)
  super
  @action = :create
end
