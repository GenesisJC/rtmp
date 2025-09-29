#!/bin/bash

## Variables

STREAMID=2026730
USERID=rihamona
VIDEO_SOURCE=rtmp://"rtmp server ip":1935/stream/master


## Generate and upload Master Playlist with 2 profiles

cat <<EOF >master.m3u8
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=500000,RESOLUTION=960x540
540/live.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=800000,RESOLUTION=640x360
360k/live.m3u8
EOF

curl -vT master.m3u8 http://p-ep${STREAMID}.i.akamaientrypoint.net/${STREAMID}/${USERID}/master.m3u8
sleep 2


#Encode video from mp4 downloaded file

ffmpeg -re -stream_loop -1 -i ${VIDEO_SOURCE} \
-vcodec libx264 -pix_fmt yuv420p -x264opts bframes=1:ref=3:keyint_min=25 -profile:v baseline -b:v 540k -s 960x540 -preset ultrafast \
-vf "drawtext=:text=(540K)%{localtime}:fontsize=32:x=32:y=32:box=1:boxcolor=white:fontcolor=black,drawtext=:text=%{pts \\\:hms}:x=32:y=64:fontsize=32:box=1:boxcolor=white:fontcolor=black" -g 25 -r 25 \
-f hls -hls_time 2 -hls_list_size 5 \
-start_number $(date "+%s") -method PUT -http_persistent 1 -hls_segment_filename "http://p-ep${STREAMID}.i.akamaientrypoint.net/${STREAMID}/${USERID}/540k/file-%08d.ts" "http://p-ep${STREAMID}.i.akamaientrypoint.net/${STREAMID}/${USERID}/540k/live.m3u8" \
-vcodec libx264 -pix_fmt yuv420p -x264opts bframes=1:ref=3:keyint_min=25 -profile:v baseline -b:v 360k -s 640x360 -preset ultrafast -pix_fmt yuv420p \
-vf "drawtext=:text=(360K)%{localtime}:fontsize=32:x=32:y=32:box=1:boxcolor=white:fontcolor=black,drawtext=:text=%{pts \\\:hms}:x=32:y=64:fontsize=32:box=1:boxcolor=white:fontcolor=black" -g 25 -r 25 \
-f hls -hls_time 2 -hls_list_size 5 \
-start_number $(date "+%s") -method PUT -http_persistent 1 -hls_segment_filename "http://p-ep${STREAMID}.i.akamaientrypoint.net/${STREAMID}/${USERID}/360k/file-%08d.ts" "http://p-ep${STREAMID}.i.akamaientrypoint.net/${STREAMID}/${USERID}/360k/live.m3u8"
