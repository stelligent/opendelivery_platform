actions :set

attribute :domain, :kind_of => String
attribute :json_file, :kind_of => String

def initialize(*args)
  super
  @action = :set
end
