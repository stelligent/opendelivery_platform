require_relative "boot"

sdb_domain = ARGV[0]
json_file = ARGV[1]

@sdb = AWS::SimpleDB.new

json = File.read(json_file)
obj = JSON.parse(json)

obj.each do |item, attributes|
  attributes.each do |key,value|
    @sdb.domains[sdb_domain].items[item].attributes[key].add value
  end
end
