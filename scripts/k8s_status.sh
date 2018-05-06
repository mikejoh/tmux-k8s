#!/usr/bin/env bash

# Uses kubectl to fetch information about the context and the namespace

get_status() {
    status=""
    if !(hash kubectl) 2>/dev/null
    then
        status="N/A:N/A()"
    else
        context=$(kubectl config current-context)
        result=$(kubectl config view | grep namespace)

        if [ -z "$result" ]
        then
            namespace="N/A"
        else
            namespace=$(echo $result | awk '{ print $2 }')
        fi
        num_pods=$(kubectl get pods --no-headers | wc -l | awk '{ print $1 }')

        status="${context}:${namespace}(${num_pods})"
    fi
        
    echo "$status"
}

get_status
