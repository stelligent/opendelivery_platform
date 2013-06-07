require 'open3'

class PowerShellRunner

    def initialize hostname, username, password, remote_command
        @hostname = hostname
        @username = username
        @password = password
        @remote_command = remote_command
    end

    def execute
        std_out = ""
        std_err = ""
        command = "
$username='#{@username}'
$password='#{@password}'
$pass = ConvertTo-SecureString -AsPlainText $password -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $pass
Invoke-Command -ComputerName localhost -ScriptBlock { #{@remote_command} } -credential $cred
"
        powershell_command = "powershell -command \"& {#{command}}\""
        stdin, stdout, stderr = Open3.popen3(powershell_command) 
        stdout.each_line { |line| std_out += line}
        stderr.each_line { |line| std_err += line}

        return std_out, std_err
    end
end

remote_command = "dir"
hostname = "localhost"
username = "Administrator"
password = "EVYA)SKxy?"

psr = PowerShellRunner.new hostname, username, password, remote_command
out, err = psr.execute
puts out
puts err
