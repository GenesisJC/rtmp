FROM tiangolo/nginx-rtmp
RUN rm -rf /etc/nginx/nginx.conf
COPY nginx.conf /opt/nginx/nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /mnt/data
RUN mkdir /mnt/data/recordings
RUN mkdir /mnt/data/hls
EXPOSE 1935 8080/Users/rihamona/Documents/github/rtmp-artifact/RTMP-Relay-Server/k8s/deployment.yaml