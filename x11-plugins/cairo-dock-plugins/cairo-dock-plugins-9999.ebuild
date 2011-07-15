# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
EBZR_REPO_URI="lp:cairo-dock-plug-ins"
#EBZR_REPO_URI="lp:cairo-dock-plug-ins/2.3"
#EBZR_REVISION="1939"


inherit cmake-utils bzr

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="https://launchpad.net/cairo-dock-plug-ins/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa exif gmenu kde terminal tomboy vala webkit xfce xgamma xklavier"

RDEPEND="
	~x11-misc/cairo-dock-${PV}
	alsa? ( media-libs/alsa-lib )
	exif? ( media-libs/libexif )
	gmenu? ( gnome-base/gnome-menus )
	kde? ( kde-base/kdelibs )
	terminal? ( x11-libs/vte )
	webkit? ( >=net-libs/webkit-gtk-1.0 )
	xfce? ( xfce-base/thunar )
	xgamma? ( x11-libs/libXxf86vm )
	xklavier? ( x11-libs/libxklavier )
	vala? ( dev-lang/vala:0.12 )
"

DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig
"

pkg_setup() {
	if use gio; then
		if ! use gmenu; then
			ewarn "gio requires gmenu, implicitly added"
		fi
	fi
}

MAKE_IN_SOURCE_BUILD=true


