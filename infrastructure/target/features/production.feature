Feature: Scripted Provisioning of Target Environment
    As a Developer
    I would like my target environment provisioned correctly
    so I can deploy applications to it

    Background:
        Given I am sshed into the environment

    Scenario: Is the proper version of Apache installed?
        When I run "/usr/sbin/httpd -v"
        Then I should see "2.2"

    Scenario: Is the proper version of Java installed?
        When I run "java -version"
        Then I should see "1.6"

    Scenario: Is the proper version of Ruby installed?
        When I run "ruby -v"
        Then I should see "ruby 1.9.3"

    Scenario: Is the proper version of GCC installed?
        When I run "gcc -v"
        Then I should see "4"

    Scenario Outline: These files should be present
        When I run "sudo ls -las <file>"
        Then I should see "<file>"

        Examples: file that should exist  
        | file                |
        | /opt/aws/aws.config |
    
	
    Scenario Outline: These gems should be present
        When I run "sudo gem list"
        Then I should see "<output>"

        Examples: gems should be present
        | output  |
        | bundler |
        | aws-sdk |
    
