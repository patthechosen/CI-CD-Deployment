# Use official Ubuntu base image
FROM ubuntu:20.04

# Avoid interactive prompts during installs
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, Git, Curl
RUN apt-get update && \
    apt-get install -y apache2 git curl && \
    apt-get clean

# Prevent Apache startup warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy custom startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Copy your static web content if you want to bundle it (optional)
COPY ./webapp/ /var/www/html/

# Expose Apache port
EXPOSE 80

# Launch custom script on container startup
CMD ["/start.sh"]