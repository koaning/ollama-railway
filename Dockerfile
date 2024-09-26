FROM python:3.12

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# The installer requires curl (and certificates) to download the release archive
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download the latest installer
ADD https://astral.sh/uv/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.cargo/bin/:$PATH"

# Install required packages
RUN uv pip install nanodjango ollama

COPY ./run-ollama.sh .

RUN chmod +x run-ollama.sh && ./run-ollama.sh

# Copy app code
COPY app.py . 

# Expose port 8000 for WebApp1
EXPOSE 8000

# Use supervisord to run both web services
CMD uv run nanodjango run app.py
