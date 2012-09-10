Feature: Scripted Provisioning of Target Environment
    As a Developer
    I would like my target environment provisioned correctly
    so I can deploy applications to it

    Background:
        Given I am sshed into the environment

    Scenario: Is the proper version of Postgresql installed?
        When I run "/usr/bin/postgres --version"
        Then I should see "8.4"

    Scenario: Is the proper version of Apache installed?
        When I run "/usr/sbin/httpd -v"
        Then I should see "2.2"

    Scenario: Is the proper version of Java installed?
        When I run "java -version"
        Then I should see "1.6"

    Scenario: Is the proper version of perl installed?
        When I run "perl -version"
        Then I should see "perl, v5.10.1"

    Scenario: Is the proper version of make installed?
        When I run "make -version"
        Then I should see "GNU Make 3.81"

    Scenario: Is the proper version of Ruby installed?
        When I run "ruby -v"
        Then I should see "ruby 1.9.3"

    Scenario: Is the proper version of GCC installed?
        When I run "gcc -v"
        Then I should see "4.4.6"

    Scenario: Is Tomcat installed?
        When I check the version of Tomcat installed
        Then the major version should be 6

    Scenario Outline: Is the proper version of libxslt-devel installed?
        When I run "sudo yum info libxslt-devel"
        Then I should see "<output>"

        Examples: output I should see
            | output             |
            | Installed Packages | 
            | 1.1.26             |

    Scenario Outline: Is the proper version of libxml2-devel installed?
        When I run "sudo yum info libxml2-devel"
        Then I should see "<output>"

        Examples: output I should see
            | output             |
            | Installed Packages | 
            | 2.7.6              |

    Scenario Outline: These files should be present
        When I run "sudo ls -las <file>"
        Then I should see "<file>"

        Examples: file that should exist  
        | file                              |
        | /home/ec2-user/aws.config         |
        | /home/ec2-user/database_update.rb |
        | /var/lib/pgsql/data/pg_hba.conf   |
    
	
    Scenario Outline: These gems should be present
        When I run "sudo gem list"
        Then I should see "<output>"

        Examples: gems should be present
        | output  |
        | bundler |
        | aws-sdk |
    
