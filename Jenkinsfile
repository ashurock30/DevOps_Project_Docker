@Library('Jenkins_Shared_Library') _

pipeline{

    agent {
        label 'DEVLINUX'
    }

    parameters{

        string(name: 'branch_name', description: "Branch Name", defaultValue: 'master')
        booleanParam description: 'Set to True if you want to perform the SonarQube Scan & Quality Gate Check', name: 'Sonarqube_Scan'
        string(name: 'ImageName', description: "Name of the Image", defaultValue: 'myjavaapp')
        string(name: 'ImageTag', description: "Tag of the Image", defaultValue: '1.0.0')
        string(name: 'DockerHubUser', description: "Docker Hub User", defaultValue: '')
    }

    stages{
         
        stage('Git Checkout'){
            steps{
                gitCheckout(
                    "${params.branch_name}"
                )
            }
        }

        stage('Unit Test maven'){
            steps{
               script{  
                   mvnTest()
               }
            }
        }

        stage('Integration Test maven'){
            steps{
               script{
                   mvnIntegrationTest()
               }
            }
        }

        
        stage('Maven Build'){
            steps{
               script{
                   mvnBuild()
                }
            }
        }

        stage('SonarQube Scan '){
            when {
                environment name: 'Sonarqube_Scan', value: 'true'
            }
            steps{
               script{
                   def SonarQubecredentialsId = 'sonar-test'
                   statiCodeAnalysis(SonarQubecredentialsId)
               }
            }
        }

        stage('Quality Gate Status Check'){
            when {
                environment name: 'Sonarqube_Scan', value: 'true'
            }
            steps{
               script{
                   def SonarQubecredentialsId = 'sonar-test'
                   QualityGateStatus(SonarQubecredentialsId)
               }
            }
        }

        stage('Docker Image Build'){
            steps{
               script{
                   dockerBuild("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }

        stage('Docker Image Scan'){
            steps{
               script{
                   dockerImageScan("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }

        // stage('Docker Image Push : DockerHub '){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            dockerImagePush("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
        //        }
        //     }
        // }   
        // stage('Docker Image Cleanup : DockerHub '){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            dockerImageCleanup("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
        //        }
        //     }
        // }     
    }

    post {
        always {
            cleanWs()
            echo "Workspace Cleaned"
        }
        success {
            // Actions to be taken if the build is successful
            echo 'Build successful!'

            // Example: Trigger downstream jobs or deployments
            // build job: 'Deploy-App', wait: false
        }
        failure {
            // Actions to be taken if the build fails
            echo 'Build failed!'
        }
    }
}