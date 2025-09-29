# rtmp
Deployment on RTMP on K8S

1. git@github.com:GenesisJC/rtmp.git
2. cd rtmp
3. sudo docker build -t "your docker image":"tag" .
4. sudo docker tag "your docker image":"tag"  "dockerhub account"/"your docker image":"tag"
5. sudo docker push "dockerhub account"/"your docker image":"tag"
6. kubectl apply -f yaml/deployment.yaml 
7. kubectl apply -f yaml/service.yaml 
8. kubectl get svc, and get your external ip
9. use the external ip as stream server for OBS : rtmp://external-ip:1935/stream
