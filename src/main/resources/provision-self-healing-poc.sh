#Automation Event Decisions kjars
git clone https://github.com/snandakumar87/AutomationEventDecision
cd AutomationEventDecision
mvn clean install
cd ..

#Event Producer (REST endpoint)
oc new-app quay.io/quarkus/ubi-quarkus-native-s2i:19.3.1-java8~https://github.com/snandakumar87/kafka-sensu-producer
oc cancel-build bc/kafka-sensu-producer
#Patch for native build
oc patch bc/kafka-sensu-producer -p '{"spec":{"resources":{"limits":{"cpu":"4", "memory":"4Gi"}}}}'
oc start-build bc/kafka-sensu-producer
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
oc new-app quay.io/quarkus/ubi-quarkus-native-s2i:19.3.1-java8~https://github.com/snandakumar87/self-healing-consumer
oc cancel-build bc/self-healing-consumer
oc patch bc/self-healing-consumer -p '{"spec":{"resources":{"limits":{"cpu":"4", "memory":"4Gi"}}}}'
oc start-build bc/self-healing-consumer
oc expose svc/self-healing-consumer
