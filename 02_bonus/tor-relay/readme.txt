# Runing container

docker run -d \
    -v /etc/localtime:/etc/localtime \ 
    -p 9001:9001 \
    --name tor-relay \
    <built-image> -f /etc/tor/torrc.<brigde, middle, exit> # Depend of your nuts
