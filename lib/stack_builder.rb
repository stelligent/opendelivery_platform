require_relative "boot"

class StackBuilder
  def self.build(template, stack_name, parameters = {})
    cfn = AWS::CloudFormation.new
    stack = cfn.stacks.create(stack_name,
                              File.open(template, "r").read,
                              :parameters => parameters,
                              :capabilities => ["CAPABILITY_IAM"])

    while stack.status != "CREATE_COMPLETE"
      sleep 30

      case stack.status
      when "ROLLBACK_IN_PROGESS"
        stack.delete
      when "ROLLBACK_COMPLETE"
        stack.delete
      end
    end

    stack = cfn.stacks[stack_name]
    File.open("/tmp/#{stack_name}", "w") do |aFile|
      stack.outputs.each do |output|
        cfnOutput = "#{output.key}=#{output.value}\n"
        aFile.syswrite(cfnOutput)
      end
    end
  end
end
