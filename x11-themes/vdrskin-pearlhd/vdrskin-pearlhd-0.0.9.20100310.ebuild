# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="VDR text2skin: pearlhd"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/skin-pearlhd"
SRC_URI="http://vdr.websitec.de/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="" #yaepg

DEPEND=""
RDEPEND="${DEPEND}
		>=media-plugins/vdr-text2skin-1.3"

S="${WORKDIR}/skin-pearlhd"

src_prepare() {
	sed -i Makefile -e "s:SKINDIR  =:SKINDIR ?=:"

#	use yaepg && sed -i Make.config -e 's:#YAEPGHD=1:YAEPGHD = 1:'
}

src_install() {

	einstall DESTDIR="${D}" SKINDIR="/usr/share/vdr/text2skin/PearlHD" || die "einstall failed"

	rm "${D}"usr/share/vdr/text2skin/PearlHD/COPYING
	dodoc  HISTORY README*
}
