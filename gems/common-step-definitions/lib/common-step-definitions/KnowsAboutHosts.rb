require_relative 'KnowsHowToRun'
module KnowsAboutHosts
  include KnowsHowToRun

  def node_name
    make_node_name(target_hostname)
  end

  def target_hostname()
    self.output_lines = @run_cmd.run("hostname")
    last_output_line.chomp
  end

end

World(KnowsAboutHosts)
