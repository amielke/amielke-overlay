# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit versionator

MY_P=${PN}-${PV/_p/-}
MY_PV_MAJ_MIN=$(get_version_component_range 1-2)
MY_PV_MAJ_MIN_MIC=$(get_version_component_range 1-3)

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="http://www.glx-dock.org"
SRC_URI="http://launchpad.net/cairo-dock-plug-ins/${MY_PV_MAJ_MIN}/${MY_PV_MAJ_MIN_MIC}/+download/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa compiz dnd2share exif gio gmenu gnome kde mail network-monitor nls
	powermanager rssreader rhythmbox scoobydo terminal tomboy webkit wifi xfce
	xgamma xklavier xrandr"

RDEPEND="~x11-misc/cairo-dock-${PV}
	alsa? ( media-libs/alsa-lib )
	exif? ( media-libs/libexif )
	gmenu? ( gnome-base/gnome-menus )
	terminal? ( x11-libs/vte )
	webkit? ( >=net-libs/webkit-gtk-1.0 )
	xfce? ( xfce-base/thunar )
	xgamma? ( x11-libs/libXxf86vm )
	xklavier? ( x11-libs/libxklavier )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig"

S="${WORKDIR}"/${MY_P}

pkg_setup() {
	if use gio; then
		if ! use gmenu; then
			ewarn "gio requires gmenu, implicitly added"
		fi
	fi
}

src_prepare() {
	local cd_plugin
	# hardcoded CFLAGS are bad
	for cd_plugin in $(find "${S}/." -maxdepth 1 -type d ! -name . ! -name po); do
		# reverse Makefile.in
		sed -e '1!G;h;$!d' -i ${cd_plugin}/src/Makefile.in || \
			die "Sedding ${cd_plugin}/src/Makefile.in failed"
		# remove -O3 and trailing backslash of following line (which is
		# previous in original file)
		sed -e '/-O3$/{N;s:.*-O3\n::;s:\\$::}' \
			-i ${cd_plugin}/src/Makefile.in || \
			die "Sedding ${cd_plugin}/src/Makefile.in failed"
		# reverse Makefile.in again
		sed -e '1!G;h;$!d' -i ${cd_plugin}/src/Makefile.in || \
			die "Sedding ${cd_plugin}/src/Makefile.in failed"
	done
	# Fixing po/POTFILES.in
	find "${S}"/*/src -name *.c | sed \
		-e 's:.*/\(.*/src/.*\.c\):\1:' > "${S}/po/POTFILES.in" || \
		die "Fixing po/POTFILES.c failed"
}

src_configure() {
	econf --disable-dependency-tracking           \
		--disable-old-gnome-integration           \
		$(use_enable alsa alsa-mixer)             \
		$(use_enable compiz compiz-icon)          \
		$(use_enable dnd2share)                   \
		$(use_enable exif)                        \
		$(use_enable gio gio-in-gmenu)            \
		$(use_enable gio gmenu)                   \
		$(use_enable gmenu)                       \
		$(use_enable gnome gnome-integration)     \
		$(use_enable kde kde-integration)         \
		$(use_enable mail)                        \
		$(use_enable rhythmbox musicplayer)       \
		$(use_enable network-monitor)             \
		$(use_enable nls)                         \
		$(use_enable powermanager)                \
		$(use_enable rssreader)                   \
		$(use_enable scoobydo scooby-do)          \
		$(use_enable terminal)                    \
		$(use_enable tomboy)                      \
		$(use_enable webkit weblets)              \
		$(use_enable wifi)                        \
		$(use_enable xfce xfce-integration)       \
		$(use_enable xgamma)                      \
		$(use_enable xklavier keyboard-indicator) \
		$(use_enable xrandr xrandr-in-show-desktop)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	elog "The applets 'Cpusage', 'Ram-meter' and 'Nvidia' are merged now into"
	elog "'System-Monitor' applet."
}
