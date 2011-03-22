#^ Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
EBZR_REPO_URI="lp:cairo-dock-plug-ins"

inherit cmake-utils bzr

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="https://launchpad.net/cairo-dock-plug-ins/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa compiz dnd exif extras gio gmenu gnome kde mail musicplayer networkmonitor powermanager rss terminal tomboy webkit wifi xfce xgamma xrandr xklavier"

RDEPEND="x11-libs/cairo
	dev-libs/dbus-glib
	dev-libs/libxml2
	gnome-base/librsvg
	x11-libs/gtk+:2
	x11-libs/gtkglext
	~x11-misc/cairo-dock-${PV}
	alsa? ( media-libs/alsa-lib )
	exif? ( media-libs/libexif )
	gio? ( gnome-base/gnome-menus )
	gmenu? ( gnome-base/gnome-menus )
	mail? ( net-libs/libetpan )
	terminal? ( x11-libs/vte )
	webkit? ( >=net-libs/webkit-gtk-1.0 )
	xfce? ( xfce-base/thunar )
	xgamma? ( x11-libs/libXxf86vm )
	xklavier? ( x11-libs/libxklavier )
	xrandr? ( x11-libs/libXrandr )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}-${MY_PV}"

pkg_setup() {
	use gio && ! use gmenu && \
		ewarn "gio requires gmenu, implicitly added"
}

src_prepare() {
	# Fix infinite loop in po/
	# (What are these buggy autotools ?)
	eautoreconf

#	epatch "${FILESDIR}/${PN}-${PV//_p*}-clean-up-cflags.patch"
}

src_configure() {
	econf 	$(use_enable alsa alsa-mixer) \
		$(use_enable compiz compiz-icon) \
		$(use_enable dnd dnd2share) \
		$(use_enable exif) \
		$(use_enable extras scooby-do) \
		$(use_enable gio gio-in-gmenu) \
		$(use_enable gio gmenu) \
		$(use_enable gmenu) \
		$(use_enable gnome gnome-integration) \
		$(use_enable kde kde-integration) \
		$(use_enable mail) \
		$(use_enable musicplayer) \
		$(use_enable networkmonitor) \
		$(use_enable powermanager) \
		$(use_enable rss rssreader) \
		$(use_enable terminal) \
		$(use_enable tomboy) \
		$(use_enable webkit weblets) \
		$(use_enable wifi) \
		$(use_enable xfce xfce-integration) \
		$(use_enable xgamma) \
		$(use_enable xrandr xrandr-in-show-desktop) \
		$(use_enable xklavier keyboard-indicator)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

