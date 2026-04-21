#!/bin/bash

# 1. Variables
IMAGE_NAME="my-secure-app"
CONTAINER_NAME="webapp-prod"
PORT=8080
SERVICE_PATH="${HOME}/.config/systemd/user"
SERVICE_NAME="container-${CONTAINER_NAME}.service"

echo "--- Starting Clean Deployment ---"

# 2. Cleanup existing environment (Crucial for scripts)
echo "Cleaning up old containers and services..."
systemctl --user stop ${SERVICE_NAME} 2>/dev/null
podman rm -f ${CONTAINER_NAME} 2>/dev/null
rm -f ${SERVICE_PATH}/${SERVICE_NAME}

# 3. Build the Image
echo "Building Podman image..."
podman build -t ${IMAGE_NAME}:latest .

# 4. Create the container (We 'create' so systemd can 'start' it)
echo "Creating container..."
podman create --name ${CONTAINER_NAME} -p ${PORT}:${PORT} ${IMAGE_NAME}:latest

# 5. Generate and Load systemd Unit
echo "Configuring systemd..."
mkdir -p ${SERVICE_PATH}
podman generate systemd --name ${CONTAINER_NAME} --files --new

# Move to systemd folder
mv ${SERVICE_NAME} ${SERVICE_PATH}/

# 6. Final Activation
echo "Activating Service..."
systemctl --user daemon-reload
systemctl --user enable --now ${SERVICE_NAME}

echo "--- Deployment Success ---"
echo "Check status with: systemctl --user status ${SERVICE_NAME}"
