# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="All-In-One Solution for Remote Access and Support over the Internet"
HOMEPAGE="http://www.teamviewer.com"
SRC_URI_BASE="http://www.teamviewer.com/download/"
SRC_URI="x86? ( ${SRC_URI_BASE}${PN}_linux.deb -> ${P}_x86.deb )
	amd64? ( ${SRC_URI_BASE}${PN}_linux_x64.deb -> ${P}_amd64.deb )"

LICENSE="TeamViewer"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror strip"

RDEPEND="app-emulation/wine"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
	rm -f control.tar.gz data.tar.gz debian-binary
}

src_install () {
	echo "#!/bin/bash" > ${PN} || die
	echo "export WINEDLLPATH=/opt/${PN}" >> ${PN} || die
	echo "wine /opt/${PN}/TeamViewer.exe" >> ${PN} || die

	insinto /opt/${PN}/
	doins opt/teamviewer8/tv_bin/wine/drive_c/TeamViewer/*
	doins ${PN}

	insinto /usr/sbin
	doins opt/teamviewer8/tv_bin/teamviewerd
	fperms +x /usr/sbin/teamviewerd

	fperms 755 /opt/${PN}/${PN}
	dosym /opt/${PN}/${PN} /opt/bin/${PN}

	doicon -s 48 opt/teamviewer8/tv_bin/desktop/${PN}.png

	dodoc opt/teamviewer8/linux_FAQ_{EN,DE}.txt
	dodoc opt/teamviewer8/CopyRights_{EN,DE}.txt

	make_desktop_entry ${PN} TeamViewer \
	/opt/${PN}/tv_bin/desktop/${PN}.png 'Network;'

	newinitd "${FILESDIR}/teamviewerd.rc" ${PN}
}
