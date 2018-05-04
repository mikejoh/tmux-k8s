#!/usr/bin/env bash

# Uses kubectl to fetch information about the context and the namespace

get_status() {
    status=""
    if !(hash kubectl) 2>/dev/null
    then
        status="N/A:N/A"
    else
        context=$(kubectl config current-context)
        if !(kubectl config view | grep namespace)
        then
            namespace="N/A"
        else
            namespace=$(kubectl config view | grep namespace | awk '{ print $2 }')
        fi
        status="${context}:${namespace}"
    fi
        
    echo "$status"
}

get_status
