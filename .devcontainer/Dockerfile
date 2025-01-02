FROM mcr.microsoft.com/devcontainers/dotnet:9.0-bookworm

# Avoid warnings by switching to noninteractive
ENV NONINTERACTIVE=1

# Install terraform
RUN apt-get update && apt-get install -y curl unzip

# Install specific version of terraform
ARG TERRAFORM_VERSION=1.10.3

# Install specific version of Azure CLI
ARG AZURE_CLI_VERSION=2.67.0

# Install Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/terraform && \
    rm terraform.zip && \
    terraform --version

# Install Azure CLI
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /usr/share/keyrings/microsoft.asc.gpg > /dev/null && \
    AZ_REPO=$(lsb_release -cs) && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.asc.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install -y azure-cli=${AZURE_CLI_VERSION}-1~$AZ_REPO && \
    apt-mark hold azure-cli && \
    az --version

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*