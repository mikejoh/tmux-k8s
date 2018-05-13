#!/usr/bin/env bash

# Tmux status bar script to fetch information on k8s environments

get_pods() {
    pods=$(kubectl get pods --no-headers | wc -l | awk '{ print $1 }')
    echo "$pods"
}

get_status() {

    if !(hash kubectl) 2>/dev/null
    then
        status="kubectl not found!"
    else
        context=$(kubectl config current-context)
        result=$(kubectl config view | grep namespace)

        if [ -z "$result" ]
        then
            namespace="N/A"
        else
            namespace=$(echo $result | awk '{ print $2 }')
        fi
        
        pods=$(get_pods)

        status="${context}:${namespace}(${pods})"
    fi
        
    echo "$status"
}

get_status
