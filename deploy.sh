# we are tagging the images with :latest to be sure the :latest is always the latest version, and with a :SHA to be able to correclty update the images version on production
docker build -t nicolaslazzos/multiple-docker-client:latest -t nicolaslazzos/multiple-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t nicolaslazzos/multiple-docker-server:latest -t nicolaslazzos/multiple-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t nicolaslazzos/multiple-docker-worker:latest -t nicolaslazzos/multiple-docker-worker:$SHA -f ./worker/Dockerfile ./worker

# push all the images to docker hub
docker push nicolaslazzos/multiple-docker-client:latest
docker push nicolaslazzos/multiple-docker-server:latest
docker push nicolaslazzos/multiple-docker-worker:latest
docker push nicolaslazzos/multiple-docker-client:$SHA
docker push nicolaslazzos/multiple-docker-server:$SHA
docker push nicolaslazzos/multiple-docker-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=nicolaslazzos/multiple-docker-client:$SHA
kubectl set image deployments/server-deployment server=nicolaslazzos/multiple-docker-server:$SHA
kubectl set image deployments/worker-deployment worker=nicolaslazzos/multiple-docker-worker:$SHA