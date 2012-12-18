Feature: Scripted Deployment of an Application
    As a Developer
    I would like my Deployment to be successful
    so I can use the application

    Background:
        Given I am sshed into the environment

    Scenario: Is the httpd service running?
        When I run "ps -ef | grep httpd"
        Then I should see "httpd"

    Scenario Outline: These files should be present
        When I run "sudo ls -las <file>"
        Then I should see "<file>"

        Examples: file that should exist
        |file     |
        |/etc/httpd/conf/httpd.conf|