#!/bin/bash

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo "Test whatos.denicolafamily.com from $INGRESS_HOST"
for i in {1..100}; do curl --header 'Host: whatos.denicolafamily.com' http://$INGRESS_HOST/api/os; done
