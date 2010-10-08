# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# This ebuild is based on ngoonee's arch linux PKGBUILD
# (http://aur.archlinux.org/packages.php?ID=35631)

# Todo:
# - Logfiles are as far as i can see only rotated on application restart and can
#   grow over time. Maybe add a config for logrotate
# - The init-script does not catch all startup errors

DESCRIPTION="Open Source SyncML-Server"
HOMEPAGE="http://www.funambol.org/"

This is the official server but at the time of writing x64-file was corrupted
SRC_URI="   x86? ( http://download.forge.objectweb.org/sync4j/${P}.tgz )
		  amd64? ( http://download.forge.objectweb.org/sync4j/${P}-x64.tgz ) "

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/jre dev-lang/python"
DEPEND="${RDEPEND}"

S="${WORKDIR}/Funambol"

src_install() {
	dodir "/opt/Funambol"
	cp -pR "${S}"/* "${D}"/opt/Funambol || die "failed to copy files"
	newinitd "${FILESDIR}"/Funambol.init Funambol || die "init"

	# Remove built-in JRE
	rm -Rf "${D}"/opt/Funambol/tools/jre-*

	# Edit config to use JAVA_HOME
	cat "${D}"/Funambol/admin/etc/funamboladmin.conf \
	| sed 's/^default_userdir.*$/default_userdir=~\/.config\/funambol/' \
	| sed 's/^jdkhome/# jdkhome/' \
	> "${D}"/opt/Funambol/admin/etc/funamboladmin.conf

	#Symlink admin gui
	dosym /opt/Funambol/admin/bin/funamboladmin /usr/bin/funamboladmin
}

