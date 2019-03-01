#!/usr/bin/env bash

# Tmux status bar script to fetch information on k8s environments

get_running_pods() {
    pods=$(kubectl get pods --no-headers --field-selector=status.phase=Running --request-timeout 1s | wc -l | awk '{ print $1 }')
    echo "$pods"
}

get_status() {

    if !(hash kubectl) 2>/dev/null
    then
        status="kubectl not found!"
    else
        context=$(kubectl config current-context)
        context_info=$(kubectl config get-contexts --no-headers)
        namespace=$(echo "$context_info" | grep "*" | awk '{print $5}')
        cluster=$(echo "$context_info" | grep "*" | awk '{print $3}')

        if [ -z "$namespace" -o -z "$context" -o -z "$context_info" ]
        then
            context="N/A"
            context_info="N/A"
            namespace="N/A"
        fi
        
        pods=$(get_running_pods)

        status="ctx:${context} clu:${cluster} ns:${namespace} pods:${pods}"
    fi
        
    echo "$status"
}

get_status
