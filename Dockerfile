FROM ollama/ollama

# Install Ollama
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
# RUN curl -fsSL https://ollama.com/install.sh | sh
RUN ollama serve & ollama pull llama3.2:1b
# Install required packages
RUN uv pip install nanodjango

# Copy app code
COPY app.py . 

# Expose port 8000 for WebApp1
EXPOSE 8000

# Use supervisord to run both web services
CMD nanodjango run app.py
