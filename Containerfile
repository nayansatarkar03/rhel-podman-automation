# Use a slim RHEL-based image
FROM registry.access.redhat.com/ubi8/python-39:latest

# Set metadata
LABEL maintainer="YourName"

# Install dependencies
COPY --chown=1001:0 requirements.txt .
RUN pip install --no-cache-dir flask

# Copy application code
COPY --chown=1001:0 app.py .

# Expose the port
EXPOSE 8080
# Run as non-root user (UID 1001 is default in UBI python image)
USER 1001

CMD ["python", "app.py"]

