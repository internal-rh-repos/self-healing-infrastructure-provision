#Automation Event Decisions kjars
git clone https://github.com/snandakumar87/AutomationEventDecision
cd AutomationEventDecision
mvn clean install
cd ..

#Event Producer (REST endpoint)
oc new-app registry.access.redhat.com/ubi8/openjdk-11:latest~https://github.com/snandakumar87/kafka-sensu-producer
oc expose svc/kafka-sensu-producer

#Micro services
git clone https://github.com/snandakumar87/self-healing-services
cd self-healing-services
cd check-event-service
mvn fabric8:deploy

cd ..
cd invoke-ansible
mvn fabric8:deploy
cd ..

cd ansible-status
mvn fabric8:deploy
cd ..

cd create-incident
mvn fabric8:deploy
cd ..

#Consumer UI application
oc new-app registry.access.redhat.com/ubi8/openjdk-11:latest~https://github.com/snandakumar87/self-healing-consumer
oc expose svc/self-healing-consumer