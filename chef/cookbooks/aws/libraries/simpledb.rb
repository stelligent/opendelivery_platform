module SimpleDbLib
  def self.set_property(domain, item, property, value)
    require 'aws-sdk'
    sdb = AWS::SimpleDB.new

    AWS::SimpleDB.consistent_reads do
      item = sdb.domains[domain].items[item]

      item.attributes.set(property => [value])
    end
  end

  def self.load_domain(domain, json_file)
    require 'aws-sdk'

    sdb = AWS::SimpleDB.new

    json = File.read(json_file)
    obj = JSON.parse(json)

    obj.each do |item, attributes|
      attributes.each do |key,value|
        sdb.domains[domain].items[item].attributes[key].add value
      end
    end
  end


  def self.create_domain(domain)
    require 'aws-sdk'
    sdb = AWS::SimpleDB.new
    AWS::SimpleDB.consistent_reads do
      sdb.domains.create(domain)
    end
  end
end
