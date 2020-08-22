#!/usr/bin/env bash

mvn clean package

echo 'Copy files...'

scp -i ~/.ssh/ubuntu18.pem \
    ~/IdeaProjects/sweater2/target/sweater2-1.0-SNAPSHOT.jar \
    ec2-user@ec2-54-93-195-154.eu-central-1.compute.amazonaws.com:/home/ec2-user/

echo 'Restart server...'

ssh -i ~/.ssh/ubuntu18.pem ec2-user@ec2-54-93-195-154.eu-central-1.compute.amazonaws.com << EOF

pgrep java | xargs kill -9
nohup java -jar sweater2-1.0-SNAPSHOT.jar > log.txt &

EOF

echo 'Bye'