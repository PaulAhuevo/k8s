docker build -t ahuevote/mulit-client:latest -t ahuevote/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahuevote/mulit-server:latest -t ahuevote/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahuevote/multi-worker:latest -t ahuevote/multi-worker:$SHA -f ./worker/Dockerfile ./worker

echo "pushing to docker hub..."
docker push ahuevote/multi-client:latest
docker push ahuevote/multi-server:latest
docker push ahuevote/multi-worker:latest

echo "pushing to docker hub with SHA..."
docker push ahuevote/multi-client:$SHA
docker push ahuevote/multi-server:$SHA
docker push ahuevote/multi-worker:$SHA

echo "apply deployment files"
kubectl apply -f kubernetes
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment server=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment server=stephengrider/multi-worker:$SHA