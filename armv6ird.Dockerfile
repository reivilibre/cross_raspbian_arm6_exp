FROM ghcr.io/cross-rs/arm-unknown-linux-gnueabihf:main

COPY install_rasp_deb.sh /
RUN /install_rasp_deb.sh armhf libssl-dev libasound2-dev
