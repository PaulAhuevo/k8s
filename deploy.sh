docker build -t ahuevote/mulit-client:latest -t ahuevote/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahuevote/mulit-server:latest -t ahuevote/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahuevote/multi-worker:latest -t ahuevote/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ahuevote/multi-client:latest
docker push ahuevote/multi-server:latest
docker push ahuevote/multi-worker:latest

docker push ahuevote/multi-client:$SHA
docker push ahuevote/multi-server:$SHA
docker push ahuevote/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment server=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment server=stephengrider/multi-worker:$SHA