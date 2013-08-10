actions :create

attribute :domain, :kind_of => String, :name_attribute => true

def initialize(*args)
  super
  @action = :create
end
