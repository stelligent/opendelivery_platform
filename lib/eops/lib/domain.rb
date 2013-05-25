class Domain

  def initialize
    @sdb = AWS::SimpleDB.new
  end

  def create(domain_name)
    AWS::SimpleDB.consistent_reads do
      @sdb.domains.create(domain_name)
    end
  end


  def delete(domain_name)
    @sdb.domains[domain_name].delete
  end

  def load(file_name, sdb_domain, item_name)
    file = File.open("/tmp/#{file_name}", "r")
    AWS::SimpleDB.consistent_reads do
      item = @sdb.domains[sdb_domain].items[item_name]
      file.each_line do |line|
        key,value = line.split '='
        item.attributes.set( "#{key}" => "#{value}")
      end
    end
  end


  def get_property(sdb_domain, item_name, key)
    AWS::SimpleDB.consistent_reads do
    item = @sdb.domains[sdb_domain].items[item_name]

      item.attributes.each_value do |name, value|
        if name == key
          puts value.chomp
        end
      end
    end
  end

  def set_property(sdb_domain, item_name, property, value)
    AWS::SimpleDB.consistent_reads do
      item = @sdb.domains[sdb_domain].items[item_name]

      item.attributes.set(property => [value])
    end
  end
end
