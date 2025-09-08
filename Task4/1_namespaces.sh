#!/usr/bin/env bash

for ns in finance marketing rnd; do
  kubectl get ns "$ns" >/dev/null 2>&1 || kubectl create namespace "$ns"
done
kubectl get ns
