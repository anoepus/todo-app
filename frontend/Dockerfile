# Laver et image af en nginx server, som kopiere index og conf, til brug i nginx serveren.
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
# Exposer serveren til port 80 så man kan tilgå den
# Vi åbner kun frontenden op til offentligheden (Reverse proxy)... port 8080 er reserveret til backend (privat)
EXPOSE 80
