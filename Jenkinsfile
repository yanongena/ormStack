pipeline {

    stages {

        stage('Build') {
            steps {
                sh 'cd terraform'
                sh 'oci resource-manager stack create -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a --config-source stack1.zip --display-name "Stack1" --variables "{\"compartment_ocid\":\"ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a\"}"'
            }
        }
    }
}
