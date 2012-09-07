module KnowsAboutInstalls

  def application_install_dir
    @application_install_dir ||= {}
  end

end

World(KnowsAboutInstalls)
