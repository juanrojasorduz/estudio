FROM ubuntu:latest

# Update and upgrade base image
RUN apt update && apt upgrade -y

# Install dependencies to add repositories and install Python 3.10
RUN apt install -y software-properties-common

# Add the deadsnakes PPA for Python 3.10
RUN add-apt-repository ppa:deadsnakes/ppa

# Update the package list again after adding the repository
RUN apt update

# Install Python 3.10
RUN apt install -y python3.10

LABEL author="sergioinfante"

WORKDIR /app

ENV NAME sergio

# Copy all Python files to the container's /app directory
COPY *.py /app/

# Set the default command to run the hello-world.py script with Python 3.10
CMD [ "python3.10", "hello-world.py" ]