@Library('Jenkins_Shared_Library') _

pipeline{

    agent {
        label 'DEVLINUX'
    }

    parameters{

        string(name: 'branch_name', description: "Branch Name", defaultValue: '')
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

        // stage('Static code analysis: Sonarqube'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            def SonarQubecredentialsId = 'sonarqube-api'
        //            statiCodeAnalysis(SonarQubecredentialsId)
        //        }
        //     }
        // }
        // stage('Quality Gate Status Check : Sonarqube'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            def SonarQubecredentialsId = 'sonarqube-api'
        //            QualityGateStatus(SonarQubecredentialsId)
        //        }
        //     }
        // }
        // stage('Maven Build : maven'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            mvnBuild()
        //        }
        //     }
        // }
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
}