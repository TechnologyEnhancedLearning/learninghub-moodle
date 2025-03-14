# Use the base image
FROM moodlehq/moodle-php-apache:8.3

# Set environment variables
ENV MOODLE_DIR=/var/www/html
ENV PLUGIN_DIR=$MOODLE_DIR/local/plugins

# Set the working directory inside the container
WORKDIR $MOODLE_DIR

# Set build argument
ARG PLUGIN_SET
ENV PLUGIN_SET=$PLUGIN_SET

# Install plugins dynamically
RUN for plugin in $(echo $PLUGIN_SET | tr ',' ' '); do \
    wget -q https://moodle.org/plugins/download.php/$plugin.zip -O /tmp/$plugin.zip && \
    unzip -q /tmp/$plugin.zip -d /var/www/html/local/plugins && \
    rm -f /tmp/$plugin.zip; \
done

# Copy the current directory contents into the container
COPY . /var/www/html

COPY php.ini /usr/local/etc/php/php.ini

# Expose port 80 to the outside world
EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]
