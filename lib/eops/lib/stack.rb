class Stack

  def initialize
    @cfn = AWS::CloudFormation.new
  end

  def create(template, stack_name, parameters = {})
    stack = @cfn.stacks.create(stack_name,
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
  end

  def destroy(stack_name)
    stack = @cfn.stacks[stack_name]
    stack.delete
    while stack.exists?
      sleep 30
    end
  end

  def list
    @cfn.stacks.each do |stack|
      case stack.status
      when "CREATE_COMPLETE"
        puts "Stack Name: #{stack.name} | Status: Available"
      when "CREATE_IN_PROGRESS"
        puts "Stack Name: #{stack.name} | Status: In Progress"
      end
    end
  end
end
