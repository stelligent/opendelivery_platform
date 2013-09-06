module SimpleDbLib
  def self.set_property(domain, item, property, value, aws_access_key, aws_secret_access_key, region)
    require 'aws-sdk'
    sdb = AWS::SimpleDB.new(
      :access_key_id => aws_access_key,
      :secret_access_key => aws_secret_access_key,
      :region => region)


    AWS::SimpleDB.consistent_reads do
      item = sdb.domains[domain].items[item]

      item.attributes.set(property => [value])
    end
  end

  def self.load_domain(domain, json_file, aws_access_key, aws_secret_access_key, region)
    require 'aws-sdk'

    sdb = AWS::SimpleDB.new(
      :access_key_id => aws_access_key,
      :secret_access_key => aws_secret_access_key,
      :region => region)

    json = File.read(json_file)
    obj = JSON.parse(json)

    obj.each do |item, attributes|
      attributes.each do |key,value|
        sdb.domains[domain].items[item].attributes.set(key => [value])
      end
    end
  end


  def self.create_domain(domain, aws_access_key, aws_secret_access_key, region)
    require 'aws-sdk'
    sdb = AWS::SimpleDB.new(
      :access_key_id => aws_access_key,
      :secret_access_key => aws_secret_access_key,
      :region => region)

    AWS::SimpleDB.consistent_reads do
      sdb.domains.create(domain)
    end
  end
end
