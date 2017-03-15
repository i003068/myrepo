############################################################
# Dockerfile to build Python WSGI Application Containers
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER DEMO

# Internal SAP PROXY
ENV HTTP_PROXY http://proxy.wdf.sap.corp:8080
ENV HTTPS_PROXY https://proxy.wdf.sap.corp:8080
ENV NO_PROXY "localhost,127.0.0.1,10.0.0.0,*.sap.corp,wdf_1.clouds.archive.ubuntu.com"
ENV http_proxy http://proxy.wdf.sap.corp:8080
ENV http_proxy https://proxy.wdf.sap.corp:8080
ENV no_proxy "localhost,127.0.0.1,10.0.0.0,*.sap.corp,wdf_1.clouds.archive.ubuntu.com"

# Add the application resources URL
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty main universe" > /etc/apt/sources.list

# Add Monsoon Repo
# ADD sources.list /etc/apt/sources.list

# Update the sources list
RUN apt-get update

# Install Python and Basic Python Tools
RUN apt-get install -y python python-pip

# Copy the application folder inside the container
ADD /my_application /my_application

# Get pip to download and install requirements:
RUN pip install -r /my_application/requirements.txt

# Expose ports
EXPOSE 80

# Set the default directory where CMD will execute
WORKDIR /my_application

# Set the default command to execute
# when creating a new container
# i.e. using CherryPy to serve the application
CMD python server.py
