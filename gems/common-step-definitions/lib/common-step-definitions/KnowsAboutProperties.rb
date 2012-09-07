module KnowsAboutProperties

  def parsed_properties
    @parsed_properties ||= {}
  end
 
  def parsed_properties=(properties)
    @parsed_properties = properties
  end

end

World(KnowsAboutProperties)
