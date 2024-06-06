#!/bin/sh

# Cria o arquivo config.js na pasta pública do React
echo "window._env_ = {" > /usr/share/nginx/html/config.js
echo "  REACT_APP_API_BASE_URL: \"${REACT_APP_API_BASE_URL}\"," >> /usr/share/nginx/html/config.js
echo "}" >> /usr/share/nginx/html/config.js

exec "$@"
