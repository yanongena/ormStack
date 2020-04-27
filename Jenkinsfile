pipeline {
    agent any

    stages {
        stage('Build') {
            environment {
                stackOcid = "${sh(returnStdout:true,script: '/var/lib/jenkins/bin/oci resource-manager stack list -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a | jq \'.data[] | select(.\"display-name\" == \""+env.JOB_NAME+"\")\' | jq \'.id\'')}"
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
                    sh 'zip stack.zip terraform/infra.tf terraform/variables.tf'
                    if(env.stackOcid == '' || env.stackOcid == null){
                        echo "Does not exist"
                        sh '/var/lib/jenkins/bin/oci resource-manager stack create -c '+env.compartment+' --config-source stack.zip --display-name ${JOB_NAME} --variables \'{\"imageOCID\":\"'+env.image+'\",\"compartment_ocid\":\"'+env.compartment+'\",\"localAD\":\"'+env.ad+'\",\"region\":\"'+env.region+'\",\"ssh_public_key\":\"'+env.ociSSL+'\"}\' | jq \'.data.id\''
                     }
                    else {
                        echo "Exists, so updating"
                        sh 'unzip stack.zip'
                        sh 'ls -l'
                        sh '/var/lib/jenkins/bin/oci resource-manager stack update --force --config-source stack.zip --display-name ${JOB_NAME} --variables \'{\"imageOCID\":\"'+env.image+'\",\"compartment_ocid\":\"'+env.compartment+'\",\"localAD\":\"'+env.ad+'\",\"region\":\"'+env.region+'\",\"ssh_public_key\":\"'+env.ociSSL+'\"}\' --stack-id '+env.stackOcid
                    }

                }
            }
        }

        stage("Deploy") {
             environment {
                stackOcid = "${sh(returnStdout:true,script: '/var/lib/jenkins/bin/oci resource-manager stack list -c ocid1.compartment.oc1..aaaaaaaadykmnzg32nkpqb7qzhckomnecdq2w3dautxq5liwjhzwxnfd2r3a | jq \'.data[] | select(.\"display-name\" == \""+env.JOB_NAME+"\")\' | jq \'.id\'')}"
            }
            steps {
                script{
                    echo "Deploying stack ${env.stackOcid}"
                    sh '/var/lib/jenkins/bin/oci resource-manager job create --operation apply --apply-job-plan-resolution \'{\"isAutoApproved\": true}\' --stack-id '+env.stackOcid
                }
            }
        }
    }
}
