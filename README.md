# Overview
This repo contains code for my Istio learnings

# Canary Release Examples
## Version 1
* cd code/v1
* docker build -t whatos:1.0 . 

## Version 1
* cd code/v2
* docker build -t whatos:2.0 . 

## Jaeger Version 
* cd code/jaegar
* docker build -t whatos-jaeger:3.0 .
# Config Examples
* deploy/istio-codedeploy.yaml - A basic deployment example 
* deploy/istio-ssl.yaml - An basic deployment example with an TLS protected Istio Virtual Service
* deploy/istio-canary-release-*percent.yaml - An example Canary release utilizaing Istio Virtual Service weighted routing
* deploy/istio-jaeger.yaml - An example using Istio with Jaeger for Distributive Tracing via Open Telemetry

# Secure gRPC Examples

