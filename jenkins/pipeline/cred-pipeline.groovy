pipeline {
    agent any

    environment {
        secret = credentials('TEST_CRED_PIPELINE')
    }
    stages {
        stage('Example stage 1') {
            steps {
                sh 'echo $secret'
            }
        }
    }
}