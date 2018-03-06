node {
      stage('Preparation') { 
   
          git branch: 'task6', url: 'https://github.com/nobumori/DevOps.git'
      
          
      }
   
      stage('Build') {
      
      sh './gradlew build'
      
          }
   
      stage('Publish') {
      sh   'curl -v -u admin:admin123 --upload-file ./build/libs/task-2.3.4.war http://localhost:8081/nexus/content/repositories/snapshots/task7/task-2.3.4.war'
      
   }
}