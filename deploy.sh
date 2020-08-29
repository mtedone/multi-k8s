docker built -t alzamabar/multi-client:latest -t alzamabar/multi-client:$SHA -f ./client/Dockerfile ./client 
docker built -t alzamabar/multi-server:latest -t alzamabar/multi-server:latest:$SHA -f ./server/Dockerfile ./server 
docker built -t alzamabar/multi-worker:latest -t alzamabar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alzamabar/multi-client:latest
docker push alzamabar/multi-client:$SHA
docker push alzamabar/multi-server:latest
docker push alzamabar/multi-server:$SHA
docker push alzamabar/multi-worker:latest
docker push alzamabar/multi-worker:$SHA

kubectl apply -f ./k8s

kubectl set image deployment/server-deployment server=alzamabar/multi-server:$SHA
kubectl set image deployment/client-deployment client=alzamabar/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=alzamabar/multi-worker:$SHA

