actions :set

attribute :domain, :kind_of => String
attribute :item, :kind_of => String
attribute :property, :kind_of => String
attribute :value, :kind_of => String
def initialize(*args)
  super
  @action = :set
end
