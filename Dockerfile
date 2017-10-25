FROM ubuntu

# Install Nginx.
RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-add-repository -y ppa:nginx/stable \
    && apt-get update \
    && apt-get install -y nginx \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

ADD /code/ /data/www

RUN rm /etc/nginx/sites-enabled/default
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
EXPOSE 80 443 
CMD ["nginx", "-g", "daemon off;"]
