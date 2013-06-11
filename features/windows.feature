Feature: Scripted Deployment of an Application
    As a Developer
    I would like my Deployment to be successful
    so I can use the application

    Background:
        Given a server set up at "localhost"
        And a user named "Administrator"
        And a password of "password"

    Scenario: Is the IIS service running?
        When I run "iis reset /status"
        Then I should see "Status for IIS Admin Service ( IISADMIN ) : Running"


