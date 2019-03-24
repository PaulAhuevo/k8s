docker build -t ahuevote/mulit-client:latest -t ahuevote/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahuevote/mulit-server:latest -t ahuevote/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahuevote/multi-worker:latest -t ahuevote/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ahuevote/multi-client
docker push ahuevote/multi-server
docker push ahuevote/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server