FROM python:3.12

# Install Ollama
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN curl -fsSL https://ollama.com/install.sh | sh

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
