pipeline {
    agent any
    environment {
        stackOcid = "${sh(returnStdout:true,script: '/var/lib/jenkins/bin/oci resource-manager stack list -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a | jq \'.data[] | select(.\"display-name\" ==  ${JOB_NAME})\' | jq \'.id\'')}"
    }
    stages {

        stage('Build') {
            steps {
                script {
                    if(env.stackOcid == '' || env.stackOcid == 'null'){
                        echo "Does not exist"
                        sh '/var/lib/jenkins/bin/oci resource-manager stack create -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a --config-source terraform/stack1.zip --display-name ${JOB_NAME} --variables \'{\"compartment_ocid\":\"ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a\"}\' | jq \'.data.id\''
                        stackOcid = "${sh(returnStdout:true,script: '/var/lib/jenkins/bin/oci resource-manager stack list -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a | jq \'.data[] | select(.\"display-name\" ==  ${JOB_NAME})\' | jq \'.id\'')}"
                    }
                    else {
                        echo "Exists"
                    }

                }
            }
        }

        stage("Deploy") {
            steps {
                script{
                    echo "Deploying stack ${stackOcid}"
                }
            }
        }
    }
}
