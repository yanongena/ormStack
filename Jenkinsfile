pipeline {
    agent any
    stages {

        stage('Build') {
            steps {
                sh 'who'
                sh 'cd terraform'
                sh '/var/lib/jenkins/bin/oci resource-manager stack create -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a --config-source stack1.zip --display-name "Stack1" --variables "{\"compartment_ocid\":\"ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a\"}"'
            }
        }
    }
}
