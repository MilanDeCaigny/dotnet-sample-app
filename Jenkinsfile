// Volgorde opstarting.
node {
    stage('Preparation') {
        catchError(buildResult: 'SUCCESS') {
            sh 'docker stop dotnetrunning || true'
            sh 'docker rm dotnetrunning || true'
        }
    }
    stage('Start Database') {
        sh '''
            docker network create app-network || true
            if [ ! "$(docker ps -q -f name=postgresdb)" ]; then
                if [ "$(docker ps -aq -f status=exited -f name=postgresdb)" ]; then
                    docker rm postgresdb
                fi
                docker run -d \
                  --name postgresdb \
                  --network app-network \
                  -e POSTGRES_DB=appdb \
                  -e POSTGRES_PASSWORD=mysecretpassword \
                  postgres:16-alpine
            fi
        '''
    }
    stage('Build') {
        build 'BuildDotNetApp'
    }
    stage('Results') {
        build 'TestDotNetApp'
    }
}