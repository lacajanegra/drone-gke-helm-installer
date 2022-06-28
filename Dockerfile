FROM alpine:3.8

# Installing curl and python
RUN apk add --no-cache curl python bash openssl


# Downloading and installing gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin


# Downloading and installing kubectl package
RUN  curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl usr/bin/kubectl

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

# Install the Drone plugin script
COPY update.sh /bin/
# COPY service_account.json /bin/

ENTRYPOINT ["/bin/sh"]
CMD ["/bin/update.sh"]
