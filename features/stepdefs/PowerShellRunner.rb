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
        command = <<END
function remoteCommand ($remoteHost, $username, $password, $command)
{
    $pass = ConvertTo-SecureString -AsPlainText $Password -Force
    $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass

    $session = New-PSSession -ComputerName $remoteHost -Credential $Cred 
    try {
       
      invoke-command -Session $session -ScriptBlock $command -ErrorVariable errorText
    } finally {
      Remove-PSSession $session
    }

    if ($errorText) { 
      write-error "Deploy to $remoteHost failed: $errorText"
      throw "FAILED($remoteHost)"
    } else {
      echo "SUCCESS for $remoteHost"
    }
}


$cmdBlock={
  param([string]$message)
  #{@remote_command}
}

remoteCommand #{@hostname} citest\\svcAtlas QcykLqNkKd85 $cmdBlock
END

        powershell_command = "powershell -command \"& {#{command}}\""
        stdin, stdout, stderr = Open3.popen3(powershell_command) 
        stdout.each_line { |line| std_out += line}
        stderr.each_line { |line| std_err += line}

        return std_out, std_err
    end
end
