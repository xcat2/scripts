#!/bin/bash

set -x

rhel_default_package_list=(
	acl aic94xx-firmware alsa-firmware alsa-lib alsa-tools-firmware atk \
	audit audit-libs authconfig autogen-libopts avahi-libs basesystem \
	bash bc bind-libs-lite bind-license binutils btrfs-progs bzip2-libs \
	ca-certificates cairo chkconfig chrony coreutils cpio cracklib \
	cracklib-dicts crash cronie cronie-anacron crontabs cryptsetup-libs \
	cups-libs curl cyrus-sasl-lib dbus dbus-glib dbus-libs dbus-python \
	desktop-file-utils device-mapper device-mapper-event \
	device-mapper-event-libs device-mapper-libs \
	device-mapper-persistent-data dhclient dhcp-common dhcp-libs \
	diffutils dracut dracut-config-rescue dracut-network e2fsprogs \
	e2fsprogs-libs ebtables elfutils-default-yama-scope elfutils-libelf \
	elfutils-libs emacs-filesystem ethtool expat file file-libs \
	filesystem findutils fipscheck fipscheck-lib firewalld \
	firewalld-filesystem fontconfig fontpackages-filesystem freetype \
	fxload gawk gdbm gdk-pixbuf2 GeoIP gettext gettext-libs glib2 glibc \
	glibc-common gmp gnupg2 gobject-introspection gpgme gpg-pubkey \
	gpg-pubkey graphite2 grep groff-base grub2 grub2-common grub2-ppc64le \
	grub2-ppc64le-modules grub2-tools grub2-tools-extra \
	grub2-tools-minimal grubby gssproxy gtk2 gtk-update-icon-cache gzip \
	hardlink harfbuzz hicolor-icon-theme hostname hwdata info initscripts \
	iproute iprutils ipset ipset-libs iptables iputils irqbalance \
	ivtv-firmware iwl1000-firmware iwl100-firmware iwl105-firmware \
	iwl135-firmware iwl2000-firmware iwl2030-firmware iwl3160-firmware \
	iwl3945-firmware iwl4965-firmware iwl5000-firmware iwl5150-firmware \
	iwl6000-firmware iwl6000g2a-firmware iwl6000g2b-firmware \
	iwl6050-firmware iwl7260-firmware iwl7265-firmware jasper-libs \
	jbigkit-libs kbd kbd-legacy kbd-misc kernel kernel-bootwrapper \
	kernel-tools kernel-tools-libs kexec-tools keyutils keyutils-libs \
	kmod kmod-libs kpartx krb5-libs less libacl libaio libassuan libattr \
	libbasicobjects libblkid libcap libcap-ng libcollection libcom_err \
	libcroco libcurl libdb libdb-utils libdrm libedit libestr libevent \
	libfastjson libffi libgcc libgcrypt libgomp libgpg-error libgudev1 \
	libidn libini_config libjpeg-turbo libmnl libmount \
	libnetfilter_conntrack libnfnetlink libnfsidmap libnl libpath_utils \
	libpipeline libpng libpwquality libref_array librtas libseccomp \
	libselinux libselinux-python libselinux-utils libsemanage libsepol \
	libservicelog libss libssh2 libstdc++ libsysfs libtasn1 libthai \
	libtiff libtirpc libunistring libuser libutempter libuuid libverto \
	libverto-libevent libvpd libwayland-client libwayland-server libX11 \
	libX11-common libXau libxcb libXcomposite libXcursor libXdamage \
	libXext libXfixes libXft libXi libXinerama libxml2 libxml2-python \
	libXrandr libXrender libxshmfence libxslt libXxf86vm linux-firmware \
	lm_sensors-libs logrotate lshw lsscsi lsvpd lua lvm2 lvm2-libs lz4 \
	lzo m2crypto make man-db mariadb-libs mesa-libEGL mesa-libgbm \
	mesa-libGL mesa-libglapi mlocate mozjs17 ncurses ncurses-base \
	ncurses-libs net-snmp net-snmp-agent-libs net-snmp-libs net-tools \
	newt newt-python nfs-utils nspr nss nss-pem nss-softokn \
	nss-softokn-freebl nss-sysinit nss-tools nss-util ntp ntpdate \
	numactl-libs opal-prd openldap openssh openssh-clients openssh-server \
	openssl openssl-libs os-prober p11-kit p11-kit-trust pam pango parted \
	passwd pciutils pciutils-libs pcre perl perl-Carp perl-constant \
	perl-Data-Dumper perl-Encode perl-Exporter perl-File-Path \
	perl-File-Temp perl-Filter perl-Getopt-Long perl-HTTP-Tiny perl-libs \
	perl-macros perl-parent perl-PathTools perl-Pod-Escapes \
	perl-podlators perl-Pod-Perldoc perl-Pod-Simple perl-Pod-Usage \
	perl-Scalar-List-Utils perl-Socket perl-Storable perl-Text-ParseWords \
	perl-threads perl-threads-shared perl-Time-HiRes perl-Time-Local \
	pinentry pixman pkgconfig plymouth plymouth-core-libs plymouth-scripts \
	policycoreutils polkit polkit-pkla-compat popt postfix powerpc-utils \
	powerpc-utils-python ppc64-diag ppc64-utils procps-ng pth pycairo \
	pygobject2 pygpgme pygtk2 pyliblzma pyOpenSSL python python-chardet \
	python-configobj python-dateutil python-decorator python-dmidecode \
	python-ethtool python-firewall python-gobject-base python-gudev \
	python-hwdata python-iniparse python-inotify python-kitchen \
	python-libs python-linux-procfs python-lxml python-magic python-perf \
	python-pycurl python-pyudev python-schedutils python-six python-slip \
	python-slip-dbus python-urlgrabber pyxattr qrencode-libs quota \
	quota-nls readline Red_Hat_Enterprise_Linux-Release_Notes-7-en-US \
	redhat-logos redhat-release-server redhat-support-lib-python \
	redhat-support-tool rhn-check rhn-client-tools rhnlib rhnsd rhn-setup \
	rootfiles rpcbind rpm rpm-build-libs rpm-libs rpm-python rsync \
	rsyslog sed selinux-policy selinux-policy-targeted servicelog setup \
	sg3_utils sg3_utils-libs shadow-utils shared-mime-info slang snappy \
	sqlite stix-fonts subscription-manager subscription-manager-rhsm \
	subscription-manager-rhsm-certificates sudo systemd systemd-libs \
	systemd-sysv sysvinit-tools tar tcp_wrappers tcp_wrappers-libs tuned \
	tzdata usermode ustr util-linux vim-minimal virt-what wget which \
	xdg-utils xfsprogs xz xz-libs ypbind yp-tools yum yum-metadata-parser \
	yum-rhn-plugin yum-utils zlib
)

diff --changed-group-format='%>' --unchanged-group-format='' \
	<(for p in "${rhel_default_package_list[@]}"; do echo "${p}"; done | sort -u) \
	<(rpm -qa --qf '%{name}\n' | sort -u) | xargs -r rpm -e

for d in /install /etc/xcat /root/.xcat /var/lib/pgsql /var/lib/mysql /tftpboot
do
	[ -L "${d}" ] && rm -f "${d}"
done
