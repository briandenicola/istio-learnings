# Overview
This repo contains code for my Istio learnings

# Canary Release Examples
## Setup Infrastructure 
```bash
cd ./infrastructure 
task up 
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

## Deploy
* deploy/istio-codedeploy.yaml - A basic deployment example 
* deploy/istio-ssl.yaml - An basic deployment example with an TLS protected Istio Virtual Service
* deploy/istio-canary-release-*percent.yaml - An example Canary release utilizaing Istio Virtual Service weighted routing

# Tracing Example
## Setup Infrastructure 
```bash
cd ./infrastructure 
task up 
```
## Code Build
```bash
cd code/tracing
docker build -t bjd145/whatos-jaeger:3.0 .
docker push bjd145/whatos-jaeger:3.0
```

## Deploy
* deploy/istio-jaeger.yaml - An example using Istio with Jaeger for Distributive Tracing via Open Telemetry

## Test
* ./scripts/test.sh

# Secure gRPC Examples
## Setup Infrastructure 
```bash
cd ./infrastructure 
task up 
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

## Test

