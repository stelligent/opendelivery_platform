Feature: Scripted Deployment of a Manatee Application
    As a Developer
    I would like my Manatee Deployment to be successful
    so I can use the application

    Background:
        Given I am sshed into the environment

    #Scenario: The application is up and running
    #    When I run "/usr/bin/wget -qO- http://manatee0.mapntracker.com/wildtracks"
    #    Then I should see "Meet The Manatees"

    Scenario: Is the Tomcat service running?
        When I run "ps -ef | grep tomcat6" 
        Then I should see "tomcat"

    Scenario Outline: These files should be present
        When I run "sudo ls -las <file>"
        Then I should see "<file>"

        Examples: file that should exist
        |file     |
        |/etc/httpd/conf/httpd.conf|
        |/usr/share/tomcat6/.sarvatix/manatees/wildtracks/wildtracks-config.properties|


    # Include a scenario for checking wildtracks_config contents
    # Include a scenario for checking httpd.conf contents
    # Include a scenario for checking pg_hba.conf contents