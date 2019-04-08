#!/bin/bash

kubectl apply -f <(istioctl kube-inject -f $1)