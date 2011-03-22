# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit versionator

MY_P=${PN}-${PV/_p/-}
MY_PV_MAJ_MIN=$(get_version_component_range 1-2)
MY_PV_MAJ_MIN_MIC=$(get_version_component_range 1-3)

DESCRIPTION="Cairo-dock is a fast, responsive, Mac OS X-like dock."
HOMEPAGE="http://www.glx-dock.org"
SRC_URI="http://launchpad.net/cairo-dock-core/${MY_PV_MAJ_MIN}/${MY_PV_MAJ_MIN_MIC}/+download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="glitz nls xcomposite"

RDEPEND="dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libxml2
	gnome-base/librsvg
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/gtkglext
	x11-libs/libXrender
	glitz? ( media-libs/glitz )
	xcomposite? (
		x11-libs/libXcomposite
		x11-libs/libXinerama
		x11-libs/libXtst
	)"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	# Hardcoded CFLAGS are bad
	sed -e '/-O3\\$/d;/-g -ggdb\\$/d' -i src/Makefile.in || \
		die "sedding ${S}/src/Makefile.in failed"
	# Fix po/POTFILES.in
	find "${S}/src" -name *.c > "${S}/po/POTFILES.in" || \
		die "Fixing ${S}/po/POTFILES.in failed"
}

src_configure() {
	econf $(use_enable glitz) $(use_enable xcomposite xextend) $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	elog "Cairo-Dock is an app that draws on a RGBA GLX visual."
	elog "Some users have noticed that if the dock is launched,"
	elog "severals qt4-based applications could crash, like skype or vlc."
	elog "If you have this problem, add the following line into your bashrc :"
	echo
	elog "alias vlc='export XLIB_SKIP_ARGB_VISUALS=1; vlc; unset XLIB_SKIP_ARGB_VISUALS'"
	elog "see http://www.qtforum.org/article/26669/qt4-mess-up-the-opengl-context.html for more details."
}
