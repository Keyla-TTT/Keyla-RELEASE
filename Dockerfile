# Use an image with OpenJDK 11 JRE for running Java applications.
FROM openjdk:11-jre-slim
LABEL authors="giann"

# Set the working directory inside the container
WORKDIR /app

# Create the directories for assets and for the dictionaries volume
RUN mkdir -p /app/assets && mkdir -p /home/keyla/dictionaries

# Copy the downloaded assets into the /app/assets directory
# This includes the API .zip file and the CLI executables.
COPY ./release-assets/* ./assets/

# Add a volume for external dictionaries.
# The user can mount their own dictionary files here.
VOLUME /home/keyla/dictionaries

# Maintain the container running if started, to allow the user to interact.
ENTRYPOINT ["tail", "-f", "/dev/null"]