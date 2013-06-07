Feature: Scripted Deployment of an Application
    As a Developer
    I would like my Deployment to be successful
    so I can use the application

    Scenario: Is the IIS service running?
        When I run "iis reset /status"
        Then I should see "Status for IIS Admin Service ( IISADMIN ) : Running"


