export MAX_DOWNLOAD_SPEED=0
export MAX_CONCURRENT_DOWNLOADS=10
aria2c --enable-rpc --enable-dht --rpc-listen-all=false --rpc-listen-port 6800 --dht-listen-port=6881 --check-certificate=false \
   --max-connection-per-server=10 --rpc-max-request-size=1024M --max-tries=5 \
   --seed-time=0.01 --seed-ratio=1.0 --min-split-size=10M --follow-torrent=mem --follow-metalink=mem --split=10 \
   --daemon=true --allow-overwrite=true --max-overall-download-limit=$MAX_DOWNLOAD_SPEED \
   --max-overall-download-limit=0 --max-overall-upload-limit=0 --max-concurrent-downloads=$MAX_CONCURRENT_DOWNLOADS