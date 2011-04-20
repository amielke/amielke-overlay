# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbluray/libbluray-0.0.1_pre20110210.ebuild,v 1.1 2011/02/10 08:01:53 radhermit Exp $

EAPI=4

inherit base

MY_P="libbluray-${PV}"
DESCRIPTION="Xine plugin for blu-ray playback libraries"
HOMEPAGE="http://www.videolan.org/developers/libbluray.html"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	~media-libs/libbluray-${PV}
	>=media-libs/libbluray-0.0.1_pre20110210-r1
	media-libs/xine-lib
"
RDEPEND="
	${COMMON_DEPEND}
"
DEPEND="
	${COMMON_DEPEND}
	dev-util/pkgconfig
"

DOCS=( HOWTO )

S="${WORKDIR}/${MY_P}/player_wrappers/xine"
