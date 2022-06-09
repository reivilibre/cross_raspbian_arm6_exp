# Notes

* `bash build_docker_armv6ird.sh`

Works fine with plain Debian (you can uncomment the relevant lines in the Dockerfile),
but not with Raspbian.

There are some notes in `install_rasp_deb.sh` about what I've changed; `XXX` usually shows what I've changed.

Notably I `rm /etc/apt/sources.list.d/ports.list` because it seems dodgy to have Ubuntu's armhf repositories enabled when they have a different definition of armhf to Raspbian.

---

If I try and tell it to install `libssl1.1`:
`libssl1.1:armhf : Depends: libc6:armhf (>= 2.28) but it is not going to be installed`

then if I tell it to install `libc6`:

```
 libc6:armhf : Depends: libgcc1:armhf but it is not going to be installed
               Recommends: libidn2-0:armhf (>= 2.0.5~) but it is not going to be installed
```

`libgcc1:armhf : Depends: gcc-8-base:armhf (= 8.3.0-6+rpi1) but it is not going to be installed`

If I try to install `gcc-8-base:armhf` that way, it wants to remove half the world...
