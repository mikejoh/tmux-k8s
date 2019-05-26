package main

import (
	"fmt"
	"os"

	"path/filepath"

	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

//TODO(mikejoh):
// Add qps limits.

func homeDir() string {
	if h := os.Getenv("HOME"); h != "" {
		return h
	}
	return os.Getenv("USERPROFILE") // windows
}

func main() {
	var kubeconfig string

	// get kubeconfig from either env var or file
	if _, ok := os.LookupEnv("KUBECONFIG"); ok {
		kubeconfig = os.Getenv("KUBECONFIG")
	} else if home := homeDir(); home != "" {
		kubeconfig = filepath.Join(home, ".kube", "config")
	}

	// use the current context in kubeconfig
	config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
	if err != nil {
		panic(err.Error())
	}

	// create the clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		panic(err.Error())
	}

	pods, err := clientset.CoreV1().Pods("").List(metav1.ListOptions{})
	if err != nil {
		panic(err.Error())
	}

	numPods := len(pods.Items)

	fmt.Printf("clu:%s ns:%s pods:%d\n", "foo", "bar", numPods)
}
