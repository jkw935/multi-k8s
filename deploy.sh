docker build -t jkw935/multi-client -t jkw935/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t jkw935/multi-server -t jkw935/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jkw935/multi-worker -t jkw935/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jkw935/multi-client:latest
docker push jkw935/multi-server:latest
docker push jkw935/multi-worker:latest

docker push jkw935/multi-client:$SHA
docker push jkw935/multi-server:$SHA
docker push jkw935/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jkw935/multi-server:$SHA
kubectl set image deployments/client-deployment server=jkw935/multi-client:$SHA
kubectl set image deployments/worker-deployment server=jkw935/multi-worker:$SHA
