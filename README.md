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
cd code/v1
docker build -t whatos:1.0 . 
```

### Version 2
```bash
* cd code/v2
* docker build -t whatos:2.0 . 
```

### Jaeger
```bash
* cd code/jaegar
* docker build -t whatos-jaeger:3.0 .
```

## Deploy Examples
* deploy/istio-codedeploy.yaml - A basic deployment example 
* deploy/istio-ssl.yaml - An basic deployment example with an TLS protected Istio Virtual Service
* deploy/istio-canary-release-*percent.yaml - An example Canary release utilizaing Istio Virtual Service weighted routing
* deploy/istio-jaeger.yaml - An example using Istio with Jaeger for Distributive Tracing via Open Telemetry

## Test
* ./scripts/test.sh

# Secure gRPC Examples
## Setup Infrastructure 
```bash
    cd ./infrastructure 
    task up 
```

