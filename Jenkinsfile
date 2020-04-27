pipeline {
    agent any

    stages {
        stage('Build') {
            environment {
                stackOcid = "${sh(returnStdout:true,script: '/var/lib/jenkins/bin/oci resource-manager stack list -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a | jq \'.data[] | select(.\"display-name\" == \"ORM/master\")\' | jq \'.id\'')}"
                ociSSL = credentials("ociSSL")
                compartment = 'ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a'
                region = 'eu-frankfurt-1'
                ad = 'uFjs:EU-FRANKFURT-1-AD-2'
                image = 'ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaitzn6tdyjer7jl34h2ujz74jwy5nkbukbh55ekp6oyzwrtfa4zma'
            }
            steps {
                script {
                    echo "stack: ${env.stackOcid}"
                    echo "SSL: ${env.ociSSL}"

                    if(env.stackOcid == '' || env.stackOcid == null){
                        echo "Does not exist"
                        sh '/var/lib/jenkins/bin/oci resource-manager stack create -c '+env.compartment+' --config-source terraform/stack1.zip --display-name ${JOB_NAME} --variables \'{\"imageOCID\":\"'+env.image+'\",\"compartment_ocid\":\"'+env.compartment+'\",\"localAD\":\"'+env.ad+'\",\"region\":\"'+env.region+'\",\"ssh_public_key\":\"'+env.ociSSL+'\"}\' | jq \'.data.id\''
                     }
                    else {
                        echo "Exists, so updating"
                        sh "/var/lib/jenkins/bin/oci resource-manager stack update --force --config-source terraform/stack1.zip --display-name ${JOB_NAME} --variables \'{\"imageOCID\":\"'+env.image+'\",\"compartment_ocid\":\"'+env.compartment+'\",\"localAD\":\"'+env.ad+'\",\"region\":\"'+env.region+'\",\"ssh_public_key\":\"'+env.ociSSL+'\"}\' --stack-id ${env.stackOcid} "
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
