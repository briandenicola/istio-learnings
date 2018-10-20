#!/bin/bash

export sleep_pod=`kubectl get pods -o json | jq '.items[] | select(.metadata.name | contains("sleep")) | .metadata.name' | sed -e 's/^"//' -e 's/"$//'`
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo "Test from $INGRESS_HOST"
for i in 1 2 3 4 5 6 7 8 9 10; do curl http://$INGRESS_HOST/api/os; done

echo "Test from $sleep_pod"
kubectl exec $sleep_pod -- bash -c "for i in 1 2 3 4 5 6 7 8 9 10; do curl http://whatosistio:8081/api/os 2> /dev/null; done"
