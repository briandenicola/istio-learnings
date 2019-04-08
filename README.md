# Overview
This Repo contains code for a simple REST API to help me learn Kubernetes and istio. 
This REST API will just returns a simple JSON object with the OS that the container is running on and a version number.

# To Build
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
* deploy/simple-ingress.yaml - A simple Kubernetes Ingress Controller using nginx
* deploy/istio-jaeger.yaml - Deploys the Jaegar example container for distributive tracing
* deploy/istio-urimatch-all.yaml - A simple example with an istio Virtual Service
* deploy/istio-ssl.yaml - An example with an Istio Virtual Service using using TLS
* deploy/istio-weightedrules.yaml - An example with Isitio distributing load to two different versions of a container
