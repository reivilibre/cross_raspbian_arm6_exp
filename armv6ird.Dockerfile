FROM ghcr.io/cross-rs/arm-unknown-linux-gnueabihf:main

COPY install_rasp_deb.sh /
RUN /install_rasp_deb.sh armhf libssl-dev libasound2-dev
#RUN /install_rasp_deb.sh armhf gcc-8-base libgcc1 libc6 libssl1.1 libssl-dev libasound2-dev


#COPY install_deb.sh /
#RUN /install_deb.sh armhf libssl-dev libasound2-dev
