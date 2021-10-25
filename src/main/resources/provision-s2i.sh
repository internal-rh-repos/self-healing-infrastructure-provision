oc new-app registry.access.redhat.com/ubi8/openjdk-11:latest~https://github.com/snandakumar87/kafka-sensu-producer
oc expose svc/kafka-sensu-producer

oc new-app registry.access.redhat.com/ubi8/openjdk-11:latest~https://github.com/snandakumar87/self-healing-check-events
oc expose svc/self-healing-check-events

oc new-app registry.access.redhat.com/ubi8/openjdk-11:latest~https://github.com/snandakumar87/self-healing-services --context-dir=invoke-ansible --name=invoke-ansible
oc expose svc/invoke-ansible

oc new-app registry.access.redhat.com/ubi8/openjdk-11:latest~https://github.com/snandakumar87/self-healing-services --context-dir=ansible-status --name=ansible-stat
oc expose svc/invoke-stat

oc new-app registry.access.redhat.com/ubi8/openjdk-11:latest~https://github.com/snandakumar87/self-healing-consumer
oc expose svc/self-healing-consumer

oc new-app registry.access.redhat.com/ubi8/openjdk-11:latest~https://github.com/snandakumar87/self-healing-create-incident
oc expose svc/self-healing-create-incident




