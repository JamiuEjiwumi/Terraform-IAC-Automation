#!/bin/bash

until kubectl get service openhim-core -o jsonpath='{.status.loadBalancer.ingress[0].ip}' | grep -v '<none>'; do sleep 5; done
