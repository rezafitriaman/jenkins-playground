#!/bin/bash

# Starts ssh
# Start the OpenSSH daemon
# Listens on port 22 (by default)
# Handles SSH login attempts
# Spawns shells fr authenticated users
/usr/sbin/sshd

# Starts php process in background
# mkdir -p /run/php-fpm - Creates the directory for PHP-FPM's Unix socket file
# -p create parent directories if needed

# /usr/sbin/php-fpm -c /etc/php/fpm - Starts PHP_FPM
# -c /etc/php/fpm specifies the configuration directory

# By default, it:
# - Creates a socket at /run/php-fpm/www.sock
# - Spawns worker processes (handles PHP execution)

mkdir -p /run/php-fpm && /usr/sbin/php-fpm -c /etc/php/fpm

# Starts nginx daemon
# Forces Nginx to run in the foreground- by default it run in the background
# Docker containers need a foreground proces to stay alive
nginx -g 'daemon off;'