#!/bin/bash

sed "s/XMRPOOLADDR/${XMR_POOL}/" -i /root/config.txt
sed "s/XMRWALLET/${XMR_WALLET}/" -i /root/config.txt
sed "s/XMRPOOLPASS/${XMR_PASSWORD}/g" -i /root/config.txt

/usr/local/src/xmr-stak-cpu/bin/xmr-stak-cpu /root/config.txt

