job('job_dsl_created') {
    description('My first job')

    parameters {
        booleanParam('FLAG', true, 'I need a FLAG')
        choiceParam('OPTION', ['option 1 (default)', 'option 2', 'option 3'])
        textParam("TEXT", 'I need a water', 'Tell me hier wat u need')
    }

    scm {
        github('jenkins-docs/simple-java-maven-app', 'master', 'https')
    }

    triggers {
        cron('05 1 * * *')
    }

    steps {
        shell("echo 'Hello from DSL'")
    }
}