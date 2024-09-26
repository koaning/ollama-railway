FROM python:3.12

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Install required packages
RUN uv pip install nanodjango

# Copy app code
COPY app.py . 

# Expose port 8000 for WebApp1
EXPOSE 8000

# Use supervisord to run both web services
CMD nanodjango run app.py
