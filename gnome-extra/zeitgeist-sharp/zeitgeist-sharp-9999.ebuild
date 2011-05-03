# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zeitgeist-datahub/zeitgeist-datahub-0.7.0.ebuild,v 1.2 2011/03/05 01:54:44 signals Exp $

EAPI=4
inherit versionator bzr

EBZR_REPO_URI="lp:zeitgeist-sharp"

DESCRIPTION="zeitgeist-sharp is a managed C# wrapper of the Zeitgeist DBus API"
HOMEPAGE="http://launchpad.net/zeitgeist-sharp"
#SRC_URI="http://launchpad.net/zeitgeist-datahub/${MY_PV}/${PV}/+download/${P}.tar.gz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-libs/libzeitgeist
	app-misc/tomboy
	dev-libs/glib:2
	x11-libs/gtk+:2
	dev-lang/vala:0.12"
RDEPEND="${CDEPEND}
	gnome-extra/zeitgeist"
DEPEND="${CDEPEND}
	dev-util/pkgconfig"


src_unpack() {
	bzr_src_unpack

		# This should go to src_compile, but... (;
		cd "${S}"
	     sh autogen.sh || die "autogen"
#	    ./configure
}

