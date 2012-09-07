module KnowsHowToRun

  def run_cmd
    missing_envs = [ 'host', 'user'].select {|e| ENV[e].nil?}
    raise "ERROR: missing variables: [ #{missing_envs.join(', ')} ]" unless missing_envs.empty?
    @run_cmd ||= SecureShellRunner.new(:host_name => ENV["host"],
                                       :user      => ENV["user"],
                                       :keys      => ENV["key"])
  end

  def run_cmd=(a_run_cmd) 
    @run_cmd = a_run_cmd
  end

  def output_lines
    @output_lines ||= ""
  end

  def output_lines=(the_output_lines)
    @output_lines = the_output_lines
  end

  def last_output_line
    output_lines.split[-1]
  end

end

#World(KnowsHowToRun)
