#!/bin/sh

# On error, exit immediately
set -e

echo "Initializing pipeline..."

if [ -z ${PLUGIN_SERVICE_ACCOUNT} ]; then
    export PLUGIN_SERVICE_ACCOUNT="service_account.json"
fi

if [ -z ${PLUGIN_GKE_POJECT_ID} ]; then
    echo "gke_project_id is missing"
    exit 1
fi

if [ -z ${PLUGIN_GKE_POJECT_ID} ]; then
    echo "gke_project_id is missing"
    exit 1
fi

if [ -z ${PLUGIN_GKE_REGION} ]; then
    export PLUGIN_GKE_REGION="us-central1-a"
fi

if [ -z ${PLUGIN_GKE_CLUSTER_NAME} ]; then
    echo "gke_cluster_name is missing"
    exit 1
fi

if [ -z ${PLUGIN_HELM_CHART_REPO_NAME} ]; then
    echo "helm_chart_repo_name is missing"
    exit 1
fi

if [ -z ${PLUGIN_HELM_CHART_REPO_URL} ]; then
    echo "helm_chart_repo_url is missing"
    exit 1
fi

if [ -z ${PLUGIN_HELM_CHART_NAME} ]; then
    echo "helm_chart_name is missing"
    exit 1
fi

if [ -z ${PLUGIN_HELM_CHART} ]; then
    echo "helm_chart is missing"
    exit 1
fi

if [ -z ${PLUGIN_NAMESPACE} ]; then
    echo "namespace is missing"
    exit 1
fi

if [ -z ${PLUGIN_CUSTOM_HELM_CHART_REPO_FLAGS} ]; then
    export custom_custom_helm_chart_repo_flags=""
fi

if [ -z ${PLUGIN_CUSTOM_HELM_CHART_FLAGS} ]; then
    export custom_helm_chart_flags=""
fi


echo ""
echo "Applying GCP configutation..."
echo ""

$(gcloud auth activate-service-account --key-file=${PLUGIN_SERVICE_ACCOUNT} --project=${PLUGIN_GKE_POJECT_ID})
$(gcloud container clusters get-credentials ${PLUGIN_GKE_CLUSTER_NAME} --region ${PLUGIN_GKE_REGION}  --project ${PLUGIN_GKE_POJECT_ID})

echo ""
echo "Succesfull EKS cluster connection"
echo ""

export HELM_ADD_STRING="helm repo add ${PLUGIN_HELM_CHART_REPO_NAME} ${PLUGIN_HELM_CHART_REPO_URL} ${PLUGIN_CUSTOM_HELM_CHART_REPO_FLAGS}"

echo ""
echo "Trying to add the chart repository..."
echo "$ ${HELM_ADD_STRING}"
echo ""

 $HELM_ADD_STRING


 export HELM_INSTALLATION_STRING="helm install ${PLUGIN_HELM_CHART_NAME} ${PLUGIN_HELM_CHART} --namespace ${PLUGIN_NAMESPACE} ${PLUGIN_CUSTOM_HELM_CHART_FLAGS}"



echo ""
echo "Trying to install the chart..."
echo "$ ${HELM_INSTALLATION_STRING}"
echo ""

$HELM_INSTALLATION_STRING

echo ""
echo "Flow has ended."
