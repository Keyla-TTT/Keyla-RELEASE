# Use an image with OpenJDK 11 JRE for running Java applications.
FROM openjdk:11-jre-slim
LABEL authors="giann"

# Set the working directory inside the container
WORKDIR /app

# Create the directories for assets and for the dictionaries volume
RUN mkdir -p /app/assets && mkdir -p /home/keyla/dictionaries && mkdir -p /app/scripts

# Copy the downloaded assets into the /app/assets directory
# This includes the API .zip file and the CLI executables.
COPY ./release-assets/* ./assets/
COPY ./scripts/* ./scripts/

# Add a volume for external dictionaries.
# The user can mount their own dictionary files here.
VOLUME /home/keyla/dictionaries
COPY dictionaries/* /home/keyla/dictionaries/

# Install keyla command
RUN chmod +x keyla-linux
RUN cp keyla-linux /usr/local/bin/keyla

# Unzip the API .zip file and run the backend.
RUN chmod +x /app/istall.sh

# Create a start script that runs the backend API server in background
RUN chmod +x /app/start.sh

# Execute the backend API server in the background and keep container running
ENTRYPOINT ["/app/start.sh"]