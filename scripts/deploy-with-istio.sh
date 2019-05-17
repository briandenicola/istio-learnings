#!/bin/bash

namespace=whatosapi
kubectl -n $namespace apply -f <(istioctl kube-inject -f $1)
