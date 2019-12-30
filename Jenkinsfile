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
                    # mvn clean package install -Dmaven.test.skip=true -DpushImage -Ptest


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

                    request_data={"spec":{"template":{"spec":{"containers":[{"name":"oauth","image":"192.168.9.233/qw.test/oauth-server:test-${OAUTH_VERSION}"}]}}}}
                    echo ${request_data}
                '''
            }
        }
    }
}
