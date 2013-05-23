class Property

  def initialize
    @sdb = AWS::SimpleDB.new
  end

  def get_sdb_property(sdb_domain, item_name, key)
    AWS::SimpleDB.consistent_reads do
    item = @sdb.domains[sdb_domain].items[item_name]

      item.attributes.each_value do |name, value|
        if name == key
          puts value.chomp
        end
      end
    end
  end

  def set_sdb_property(sdb_domain, item_name, property, value)
    AWS::SimpleDB.consistent_reads do
      item = @sdb.domains[sdb_domain].items[item_name]

      item.attributes.set(property => [value])
    end
  end
end
