docker build -t geoteo/multi-client:latest -t geoteo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t geoteo/multi-server:latest -t geoteo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t geoteo/multi-worker:latest -t geoteo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push geoteo/multi-client:latest
docker push geoteo/multi-server:latest
docker push geoteo/multi-worker:latest

docker push geoteo/multi-client:$SHA
docker push geoteo/multi-server:$SHA
docker push geoteo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=geoteo/multi-server:$SHA
kubectl set image deployments/client-deployment client=geoteo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=geoteo/multi-worker:$SHA