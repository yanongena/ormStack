pipeline {
    agent any
    stages {

        stage('Build') {
            steps {
                sh 'who'
                sh 'cd terraform'
                sh 'ls -l'
                sh '/var/lib/jenkins/bin/oci resource-manager stack create -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a --config-source terraform/stack1.zip --display-name ${JOB_NAME} --variables \'{\"compartment_ocid\":\"ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a\"}\' | jq \'.data.id\''
                sh '/var/lib/jenkins/bin/oci resource-manager stack list -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a | jq \'.data[].id\''
            }
        }
    }
}
