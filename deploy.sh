docker build -t jkw5/multi-client -t jkw5/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t jkw5/multi-server -t jkw5/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jkw5/multi-worker -t jkw5/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jkw5/multi-client:latest
docker push jkw5/multi-server:latest
docker push jkw5/multi-worker:latest

docker push jkw5/multi-client:$SHA
docker push jkw5/multi-server:$SHA
docker push jkw5/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jkw5/multi-server:$SHA
kubectl set image deployments/client-deployment client=jkw5/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jkw5/multi-worker:$SHA
