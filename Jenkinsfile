pipeline {
    agent any

    stages {
        stage('Build') {
            environment {
                stackOcid = "${sh(returnStdout:true,script: '/var/lib/jenkins/bin/oci resource-manager stack list -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a | jq \'.data[] | select(.\"display-name\" == \"ORM/master\")\' | jq \'.id\'')}"
            }
            steps {
                script {
                    echo "stack: ${env.stackOcid}"
                    if(env.stackOcid == '' || env.stackOcid == null){
                        echo "Does not exist"
                        sh '/var/lib/jenkins/bin/oci resource-manager stack create -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a --config-source terraform/stack1.zip --display-name ${JOB_NAME} --variables \'{\"compartment_ocid\":\"ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a\"}\' | jq \'.data.id\''
                     }
                    else {
                        echo "Exists, so updating"
                        sh "/var/lib/jenkins/bin/oci resource-manager stack update --config-source terraform/stack1.zip --display-name ${JOB_NAME} --variables \'{\"compartment_ocid\":\"ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a\"}\' --stack-id ${env.stackOcid} "
                    }

                }
            }
        }

        stage("Deploy") {
             environment {
                stackOcid = "${sh(returnStdout:true,script: '/var/lib/jenkins/bin/oci resource-manager stack list -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a | jq \'.data[] | select(.\"display-name\" == \"ORM/master\")\' | jq \'.id\'')}"
            }
            steps {
                script{
                    echo "Deploying stack ${env.stackOcid}"
                }
            }
        }
    }
}
