file="trackers.txt"
echo "$(curl -Ns https://trackerslist.com/best_aria2.txt | awk '$1' | tr ',' '\n')" > trackers.txt
echo "$(curl -Ns https://raw.githubusercontent.com/zoeyzsz/trackerslist/master/trackers_all.txt)" >> trackers.txt
tmp=$(sort trackers.txt | uniq) && echo "$tmp" > trackers.txt
sed -i '/^$/d' trackers.txt
sed -z -i 's/\n/,/g' trackers.txt
tracker_list=$(cat trackers.txt)
if [ -f $file ] ; then
    rm $file
fi
tracker="[$tracker_list]"
export MAX_DOWNLOAD_SPEED=0
export MAX_CONCURRENT_DOWNLOADS=10
aria2c --enable-rpc --rpc-listen-all=false --rpc-listen-port 6800 --check-certificate=false \
  --max-connection-per-server=10 --rpc-max-request-size=1024M --max-tries=5 \
  --bt-tracker=$tracker --bt-max-peers=0 --bt-tracker-connect-timeout=300 --bt-stop-timeout=300 --bt-request-peer-speed-limit=1M --seed-time=0.01 --seed-ratio=1.0 \
  --min-split-size=10M --follow-torrent=mem --follow-metalink=mem --split=10 \
  --daemon=true --allow-overwrite=true --max-overall-download-limit=$MAX_DOWNLOAD_SPEED \
  --max-overall-download-limit=0 --max-overall-upload-limit=0 --max-concurrent-downloads=$MAX_CONCURRENT_DOWNLOADS