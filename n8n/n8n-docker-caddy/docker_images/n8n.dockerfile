# n8n.dockerfile
# Stage 1: get static wget + CA certs
# FROM alpine:3.20 AS tools
# RUN apk add --no-cache busybox-static ca-certificates && update-ca-certificates

# Stage 2: n8n final
FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Temporarily use HTTP repositories to avoid SSL issues, install packages, then restore HTTPS
RUN sed -i 's/https/http/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache curl bash ca-certificates && \
    update-ca-certificates && \
    sed -i 's/http:/https:/g' /etc/apk/repositories

USER node

# Set bash as the default shell for the node user
SHELL ["/bin/bash", "-c"]
