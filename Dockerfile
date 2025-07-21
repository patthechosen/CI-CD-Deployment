# Base Image
FROM amazonlinux:2

# Description
LABEL Description="Dockerfile to containerize an Apache app"

# Update all packages
RUN yum -y update

# Install Apache
RUN yum install -y httpd

# Copy the app (e.g., index.html) into the container's web directory
COPY ./webapp /var/www/html/

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
ENTRYPOINT ["/usr/sbin/httpd"]

# Run the container with Apache in the foreground
CMD ["-D", "FOREGROUND"]