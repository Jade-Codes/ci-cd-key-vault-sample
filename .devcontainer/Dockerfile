FROM mcr.microsoft.com/devcontainers/dotnet:9.0-bookworm

# Avoid warnings by switching to noninteractive
ENV NONINTERACTIVE=1

# Install Terraform
ARG TERRAFORM_VERSION=1.10.3-1

RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform=${TERRAFORM_VERSION} && \
    apt-mark hold terraform && \
    terraform --version

# Install Azure CLI
ARG AZURE_CLI_VERSION=2.67.0

RUN wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.asc.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.asc.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install -y azure-cli=${AZURE_CLI_VERSION}-1~$(lsb_release -cs) && \
    apt-mark hold azure-cli && \
    az --version

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*