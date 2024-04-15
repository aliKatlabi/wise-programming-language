pipeline {
    agent any
    
    
    stages {
        stage('CppCheck') {
            steps {
				sh 'echo "<<<CppcheckBuild>>>"'
				timeout(time: 2, unit: 'MINUTES'){
					sh 'echo "Hello world from Build Execute Shell"'
					sh 'cppcheck --xml --std=c++11 --enable=all $WORKSPACE 2> cppcheck.xml'
					sh 'echo "Here we are checking the syntax of the file in our hello job"'
					sh 'cppcheck I. /var/lib/jenkins/workspace/hello 2 > cppcheck.xml'
				}
			
           }
        }
        
        stage('Sloccount') {
            steps {
				sh 'echo "<<<Sloccountbuild>>>"'
				timeout(time: 2, unit: 'MINUTES'){
					sh 'echo "The current files in our repo, use extensions to related programming languages"'
					sh 'sloccount --duplicates --wide --details $WORKSPACE > sloccount.sc'
					sh 'cat sloccount.sc'
				}
			
           }
        }
        
        
		stage('Build') {
			steps {
					sh 'echo "<<<Building>>>"'
					timeout(time: 2, unit: 'MINUTES'){
						sh 'sh build.sh'
						archiveArtifacts artifacts: '**/bin/wise', fingerprint: true

					}
			   }
			}
        
        
        
        
        
        
	stage('Test') {
            steps {
				sh 'echo "<<<Testing>>>"'

				sh 'sh test.sh'

           }
        }
	stage('Deploy') {
            steps {
                timeout(time: 3, unit: 'MINUTES') {
                    retry(5) {
                        sh 'echo "<<<Deploying>>>"'
                    }
                }
            }
		}
    }
     post {
        always {
            echo 'One way or another, I have finished'
			
            deleteDir() /* clean up our workspace */
        }
        success {
            echo 'I succeeeded!'
            
			
        }
        unstable {
            echo 'I am unstable ??'
        }
        failure {
            echo 'I failed ??'
			
			
        }
        changed {
            echo 'Things were different before...'
        }
    }
}