# Copyright 2000-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-noepgmenu/vdr-noepgmenu-0.0.5.ebuild,v 1.2 2008/04/28 11:42:15 zzam Exp $

inherit 

IUSE=""
SLOT="0"

MY_P="${P/_beta6/PRE6}"

S="${WORKDIR}/${MY_P}"


DESCRIPTION="VDR Plugin: anonymous cut sharing marks"
HOMEPAGE="http://winni.vdr-developer.org/noepgmenu/"
SRC_URI="http://amielke.de/${MY_P}.tar.bz2"

LICENSE="GPL-2"
DEPEND=">=media-video/vdr-1.4.7-r8"
RDEPEND="${DEPEND}"

KEYWORDS="~amd64 x86"

S=${S}
src_unpack() {

		unpack ${A}
		cd ${S}
}



src_install() {
	insinto /usr/bin
	dobin "${S}/delmarks.sh"
	dobin "${S}/marks2pts"
	dobin "${S}/pts2marks"
	dobin "${S}/rwrapper.sh"

	echo
	elog "Please run marks2pts as  user in which is VDR working to create a valid config."
	echo
	elog "Add the folling line into /etc/vdr/reccmds.conf"
	echo
	elog "Schnittmarken downloaden : /usr/local/bin/pts2marks --non-interactive"
	elog "Schnittmarken uploaden :   /usr/local/bin/marks2pts --non-interactive	--upload"
	elog "Delete marks.vdr :         /usr/local/bin/delmarks.sh"
	echo
	elog "add the following option in the VDR_EXTRA_OPTIONS from /etc/conf.d/vdr to run sharemarks automatly"
	echo
	elog  "-r marks2pts"
	echo
}
