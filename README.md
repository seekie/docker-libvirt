# Docker libvirt

This image is based on centos 7.7

## Quick start

**First run:**
```
docker run -d --privileged \
    --name libvirt
    -p 16509:16509 \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    seekie/libvirt
```

And copy persistent data directories to your local
```
docker cp libvirt:/var/lib/libvirt path-to-libvirt-lib-dir
docker cp libvirt:/etc/libvirt path-to-libvirt-etc-dir
```

**All other runs:**
```
docker run -d --privileged \
    --name libvirt
    -p 16509:16509 \
    -v path-to-libvirt-lib-dir:/var/lib/libvirt \
    -v path-to-libvirt-etc-dir:/etc/libvirt \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    seekie/libvirt
```

