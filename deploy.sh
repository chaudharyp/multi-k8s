docker build -t chaudharyp/multi-client:latest -t chaudharyp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chaudharyp/multi-server:latest -t chaudharyp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chaudharyp/multi-worker:latest -t chaudharyp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chaudharyp/multi-client:latest
docker push chaudharyp/multi-server:latest
docker push chaudharyp/multi-worker:latest

docker push chaudharyp/multi-client:$SHA
docker push chaudharyp/multi-server:$SHA
docker push chaudharyp/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=chaudharyp/multi-server:$SHA
kubectl set image deployments/client-deployment client=chaudharyp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chaudharyp/multi-worker:$SHA
