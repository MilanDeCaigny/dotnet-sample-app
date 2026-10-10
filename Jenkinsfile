node {
    stage('Preparation') {
        catchError(buildResult: 'SUCCESS') {
            sh 'docker stop dotnetrunning'
            sh 'docker rm dotnetrunning'
        }
    }
    stage('Build') {
        build 'BuildDotNetApp'
    }
    stage('Results') {
        build 'TestDotNetApp'
    }
}