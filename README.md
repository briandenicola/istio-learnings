# Overview
This repo contains code for my Istio learnings

# Ambient Mesh 
>> Note: Requires istioctl version 1.23 or higher
```bash
task up
task istio-ambient #Includes Waypoint proxy for default namespace
task bookinfo
```

# Canary Release Examples
## Setup Infrastructure 
```bash
task up
task istio-basic
```

## Build
### Version 1
```bash
cd code/canary/v1
docker build -t bjd145/whatos:1.0 . 
docker push bjd145/whatos:1.0 
```

### Version 2
```bash
cd code/canary/v2
docker build -t bjd145/whatos:2.0 . 
docker push bjd145/whatos:2.0 
```

## Deploy Basic Example
```bash
kubectl apply -f ./deploy/istio-codedeploy.yaml 
```
## Deploy TLS Ingress Example
```
bash ./scripts/create-tls-secret.sh  
kubectl apply -f ./deploy/istio-ssl.yaml
```

## Deploy Canary Release Example
```bash
kubectl apply -f ./deploy/istio-canary-release-1percent.yaml 
kubectl apply -f ./deploy/istio-canary-release-10percent.yaml 
kubectl apply -f ./deploy/istio-canary-release-90percent.yaml 
```

# Tracing Example with OTEL
## Setup Infrastructure 
```bash
task up 
task istio-basic
```

## Code Build
```bash
cd code/tracing
docker build -t bjd145/whatos-jaeger:3.0 .
docker push bjd145/whatos-jaeger:3.0
```

## Deploy
```bash
kubectl apply -f ./deploy/istio-jaeger.yaml

## Test
```bash
bash ./scripts/test.sh
```

# Secure gRPC Examples
## Setup Infrastructure 
```bash
task up
task istio-basic
```
## Code Build
```bash
cd code/tracing
docker build -t bjd145/hello-service:3352bdfde61d . 
docker push bjd145/hello-service:3352bdfde61d
```

## Deploy
```bash 
bash ./scripts/create-tls-secret.sh -n istio-gateway -c ~/wildcard.local.cer -k ~/wildcard.local.key -s httpbin-credential
bash ./scripts/create-tls-secret.sh -n hellogrpc -c ~/example.local.cer -k ~/example.local.key
kubectl apply -f ./deploy/grpc/hello-example.yaml
```