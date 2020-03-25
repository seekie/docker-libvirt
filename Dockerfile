FROM scratch
MAINTAINER seekie <seekie.xyz@gmail.com>
ADD centos-7.7-x86_64-docker.tar.xz /

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="CentOS" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20191024"

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done) \
 && rm -f /lib/systemd/system/multi-user.target.wants/* \
 && rm -f /etc/systemd/system/*.wants/* \
 && rm -f /lib/systemd/system/local-fs.target.wants/* \
 && rm -f /lib/systemd/system/sockets.target.wants/*udev* \
 && rm -f /lib/systemd/system/sockets.target.wants/*initctl* \
 && rm -f /lib/systemd/system/basic.target.wants/* \
 && rm -f /lib/systemd/system/anaconda.target.wants/*

RUN yum install -y qemu-kvm libvirt libvirt-python libguestfs-tools virt-install \
 && yum clean all \
 && rm -rf /var/cache/yum

RUN systemctl enable libvirtd \
 && sed -i 's/^#LIBVIRTD_ARGS=.*/LIBVIRTD_ARGS="--listen"/' /etc/sysconfig/libvirtd \
 && sed -i 's/^#listen_tls.*/listen_tls = 0/' /etc/libvirt/libvirtd.conf \
 && sed -i 's/^#listen_tcp.*/listen_tcp = 1/' /etc/libvirt/libvirtd.conf \
 && sed -i 's/^#auth_tcp.*/auth_tcp = "none"/' /etc/libvirt/libvirtd.conf

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/var/lib/libvirt"]

CMD ["/usr/sbin/init"]

