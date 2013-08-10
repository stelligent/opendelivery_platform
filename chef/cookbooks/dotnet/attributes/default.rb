default['dotnet']['bucket'] = node['aws']['s3']['bucket']

default['dotnet']['update']['file'] = 'DotNET4.0.3-update-KB2600211-x86-x64.exe'
default['dotnet']['update']['key'] = "3rdParty/#{node['dotnet']['update']['file']}"
default['dotnet']['update']['path'] = "Z:\\#{node['dotnet']['update']['file']}"
