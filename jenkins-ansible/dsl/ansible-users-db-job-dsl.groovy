job('ansible-users-db-dsl-version') {
    description('Update html table base on the parameter')

    parameters {
        choiceParam('AGE', ['21', '22', '23', '24', '25'], 'Chose age that u want to show')
    }

    wrappers {
        colorizeOutput('xterm')
    }

    steps {
        ansiblePlaybook('/var/jenkins_home/ansible-custom/people.yml') {
            inventoryPath('/var/jenkins_home/ansible-custom/hosts')
            unbufferedOutput(true)
            colorizedOutput(true)
            extraVars {
                extraVar('PEOPLE_AGE', '${AGE}', false)
            }
            ansibleName('AnsibleLocal')
        }
    }

}