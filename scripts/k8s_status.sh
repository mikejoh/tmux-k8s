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
        context_info=$(kubectl config get-contexts --no-headers)
        namespace=$(echo "$context_info" | grep "*" | awk '{print $5})')
        cluster=$(echo "$context_info" | grep "*" | awk '{print $3}')

        if [ -z "$namespace" ]
        then
            namespace="none"
        fi
        
        pods=$(get_pods)

        status="${context}:${cluster}:${namespace}(${pods})"
    fi
        
    echo "$status"
}

get_status
