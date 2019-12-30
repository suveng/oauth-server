pipeline {
    agent any

    environment {
        VERSION = '1.0.0'
    }
    stages {
        stage('maven build....') {
            steps {
                sh '''
                    echo '开始'
                    echo '更新环境变量'
                    source /etc/profile

                    echo '登录harbor'
                    docker login 192.168.9.233 -u admin -p Harbor12345

                    echo '执行maven build,打包成jar,test环境'
                    #mvn clean package install -Dmaven.test.skip=true -DpushImage -Ptest


                    echo '完成'


                '''
            }
        }
        stage('k8s部署') {
            steps {

                sh '''
                    echo '更新版本,替换URL'

                    OAUTH_VERSION=`cat pom.xml | grep oauth-server -A 1 | grep version | grep -Eo '[0-9.]+'`
                    echo "${OAUTH_VERSION}"

                    echo '请求kuboard提供的API'

                    request_data="{\"spec\":{\"template\":{\"spec\":{\"containers\":[{\"name\":\"oauth\",\"image\":\"192.168.9.233/qw.test/oauth-server:test-${OAUTH_VERSION}\"}]}}}}"
                    echo ${request_data}


                      curl -X PATCH \
                        -H "content-type: application/strategic-merge-patch+json" \
                        -H "Authorization:Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJrdWJvYXJkLXVzZXItdG9rZW4tanJsNzUiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoia3Vib2FyZC11c2VyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiOTgyNGQ1ZDMtYjIwYi00MWY5LTliNDctMGYwYThjMmVlMmU1Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmUtc3lzdGVtOmt1Ym9hcmQtdXNlciJ9.GMXwfqmoqDI5L3m7uoHsxRGy6Vnp7oB1OwwgCfPugTuX1q-PS9_KKIByXMrJXC-NFfATHNPkmN0a5Rp3PBVOOqSjeLDnt3b9Bac9saAGPhBkpysei2OXYDkmHLxApvpqTY__OZPYOCgd0_ESILwaaON6GYjYeAnDbZbro21LmZw1o8IMjgYZZtqCvfRKWAxljOMA3Ji3hGYk4a7BatFbZFIeCgjyIVewiWKh3ywj5Tm68MR1XR1jmPvhO8zsDHlj7npqoX5sYf6BCbJBS16Ox4zMSpMVYiznCryyocSvQeBmJwMzkJaJl6Mbmikp3TnF3SbKxXlyIYcaj8vRb4723Q" \
                        -d ${request_data} \
                        "http://192.168.9.208:32567/k8s-api/apis/apps/v1/namespaces/commision-dev/deployments/svc-oauth"
                '''
            }
        }
    }
}
