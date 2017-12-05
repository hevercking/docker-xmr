FROM fedora:26
MAINTAINER Jordi Prats

# https://github.com/fireice-uk/xmr-stak-cpu
ENV XMR_POOL=pool.minexmr.com:4444
ENV XMR_WALLET=44WbnDNeS8sDtwRazRiJmuDXWavd2JCb39xrEDpNtJ3a2SxyPNg8z7WFxT6jwprDdV1iCob2uzRWDfDMY1ePhJuEQgnRTcF
ENV XMR_PASSWORD=x

RUN mkdir -p /usr/local/src

RUN dnf install findutils dbus gcc gcc-c++ hwloc-devel libmicrohttpd-devel openssl-devel cmake -y

RUN dnf install git -y
RUN git clone https://github.com/fireice-uk/xmr-stak-cpu /usr/local/src/xmr-stak-cpu

RUN bash -c 'cd /usr/local/src/xmr-stak-cpu; sed "s/fDevDonationLevel.*/fDevDonationLevel = 0.0;/" -i donate-level.h'

RUN bash -c 'cd /usr/local/src/xmr-stak-cpu; cmake .'
RUN bash -c 'cd /usr/local/src/xmr-stak-cpu; make install'

RUN bash -c 'cd /usr/local/src/xmr-stak-cpu/bin; ./xmr-stak-cpu 2>&1 | sed -n "/Copy&Paste BEGIN/,/Copy&Paste END/p" | grep -v "^*" | cat > /root/config.txt'

COPY baseconfig /root/

RUN cat /root/baseconfig >> /root/config.txt

COPY runme.sh /root/

CMD /bin/bash /root/runme.sh
