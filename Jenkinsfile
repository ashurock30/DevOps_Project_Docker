@Library('Jenkins_Shared_Library') _

pipeline{

    agent {
        label 'DEVLINUX'
    }

    parameters{

        string(name: 'branch_name', description: "Branch Name", defaultValue: 'master')
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
            steps{
               script{
                   def SonarQubecredentialsId = 'sonar-test'
                   statiCodeAnalysis(SonarQubecredentialsId)
               }
            }
        }

        stage('Quality Gate Status Check'){
            steps{
               script{
                   def SonarQubecredentialsId = 'sonar-test'
                   QualityGateStatus(SonarQubecredentialsId)
               }
            }
        }

        // stage('Docker Image Build'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            dockerBuild("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
        //        }
        //     }
        // }
        //  stage('Docker Image Scan: trivy '){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            dockerImageScan("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
        //        }
        //     }
        // }
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