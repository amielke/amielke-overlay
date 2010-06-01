# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Yacoto - Yet Another Convert Tool"
HOMEPAGE="http://www.htpc-forum.de/index.php?url=downloads.php"
SRC_URI="http://www.htpc-forum.de/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="status"

DEPEND=">=media-video/vdr-1.4"

RDEPEND="${DEPEND}
	media-video/yacoto-scripts[status=]"

src_prepare() {
	vdr-plugin_src_prepare

	# gcc-4.4
	sed -e 's:strrchr(cRec:(char *)strrchr(cRec:' -i yac-recordings.c

	sed -e 's:/etc/vdr/plugins/yacoto:/usr/share/vdr/yacoto:' -i Makefile
}
