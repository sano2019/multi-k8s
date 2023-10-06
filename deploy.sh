docker build -t sano2019/multi-client:latest -t sano2019/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sano2019/multi-server:latest -t sano2019/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sano2019/multi-worker:latest -t sano2019/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sano2019/multi-client:latest
docker push sano2019/multi-server:latest
docker push sano2019/multi-worker:latest

docker push sano2019/multi-client:$SHA
docker push sano2019/multi-server:$SHA
docker push sano2019/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sano2019/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:latest
kubectl set image deployments/worker-deployment worker=sano2019/multi-worker:$SHA
