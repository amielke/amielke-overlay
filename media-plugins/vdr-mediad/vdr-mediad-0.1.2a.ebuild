# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit vdr-plugin

DESCRIPTION="VDR plugin: tries to identify the type of media inserted by removeable devices like CD-ROM/DVD or USB sticks and mount it"

HOMEPAGE="http://www.pompase.net/"
SRC_URI="mirror://vdrfiles/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=sys-apps/hal-0.5.7
		>=sys-apps/dbus-0.61
		>=sys-apps/pmount-0.9.13
		>=media-video/vdr-1.3.43"

PATCHES="${FILESDIR}/${P}-gentoo.diff"

pkg_setup() {
	vdr-plugin_pkg_setup

	if ! getent group plugdev | grep -q vdr; then
		echo
		einfo "Add user 'vdr' to group 'plugdev'"
		echo
		elog "User vdr added to group plugdev"
		gpasswd -a vdr plugdev
	fi
}

src_install() {
	vdr-plugin_src_install

	into /usr/share/vdr/mediad
	dobin "${S}/examples/pmount.sh"

	insinto /etc/vdr/plugins/mediad
	doins "${S}/examples/mediad.conf.example"
}
