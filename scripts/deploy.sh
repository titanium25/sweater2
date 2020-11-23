#!/usr/bin/env bash

mvn clean package

echo 'Copy files...'

scp -i ~/.ssh/ubuntu_20_16112020.pem \
    ~/IdeaProjects/sweater2/target/sweater2-1.0-SNAPSHOT.jar \
    ubuntu@ec2-3-122-245-46.eu-central-1.compute.amazonaws.com:/home/ubuntu/

echo 'Restart server...'

ssh -i ~/.ssh/ubuntu_20_16112020.pem ubuntu@ec2-3-122-245-46.eu-central-1.compute.amazonaws.com << EOF

pgrep java | xargs kill -9
nohup java -jar sweater2-1.0-SNAPSHOT.jar > log.txt &

EOF

echo 'Bye'