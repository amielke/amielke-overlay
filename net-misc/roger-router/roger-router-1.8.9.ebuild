# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
inherit eutils fdo-mime gnome2-utils
DESCRIPTION="Implements fax over TCP on your Fritz!Box"
HOMEPAGE="http://www.tabos.org/ffgtk"
SRC_URI="http://de.tabos.org/download/${PN}-${PV}.tar.xz"
LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="appindicator libnotify ebook cups secret gstreamer0 gstreamer1 pulseaudio portaudio faxophone"
DEPEND="app-arch/xz-utils
media-libs/spandsp
>=net-libs/libcapi-3.0
>=x11-libs/gtk+-3.4
>=net-libs/libsoup-2.4
>=dev-libs/libpeas-1.0
>=dev-libs/glib-2.32
>=media-libs/speex-1.0"
RDEPEND="$DEPEND
cups? ( net-print/cups )
appindicator? ( dev-libs/libappindicator )
secret? ( app-crypt/libsecret )"
AUTOMAKE_OPTIONS="--force --install"
S="${WORKDIR}/${PN}-${PV}"
src_unpack() {
unpack ${A}
cd "${S}"
#eautoreconf
#intltoolize --automake --force --copy
}
src_configure() {
econf --docdir=/usr/share/doc/${PF}/html \
--with-spandsp=yes \
$(use_with appindicator appindicator3) \
$(use_with ebook) \
$(use_with libnotify) \
$(use_with secret) \
$(use_with gstreamer0) \
$(use_with gstreamer1) \
$(use_with pulseaudio) \
$(use_with portaudio) \
$(use_with faxophone)
}
src_install() {
emake DESTDIR="${D}" install
dodoc README
docinto scripts
dodoc share/install-fax.sh
if use cups ; then
exeinto /usr/libexec/cups/backend/
doexe ${D}/usr/share/roger/roger-cups
diropts -m1777
dodir /var/spool/roger
fi
#newicon roger/images/app.png roger.png
#insinto /usr/share/pixmaps
#newins roger/images/app.png roger.png
#make_desktop_entry /usr/bin/roger "Roger Router" /usr/share/roger/app.png
}
pkg_preinst() {
gnome2_icon_savelist
gnome2_schemas_savelist
}
pkg_postinst() {
fdo-mime_desktop_database_update
fdo-mime_mime_database_update
gnome2_icon_cache_update
gnome2_schemas_update
if use cups ; then
elog "Installing files for cups support."
elog "To use cups as a fax driver you have to run"
elog "Create a new Faxprinter with cups Webfrontend"
elog "http://localhost:631"
elog "The Standard PS Driver will work"
elog
fi
elog "If you want to use the incoming notification you'll have to dial #96*5*"
elog
elog "To use the capifax plugin you will have to enable capi-over-tcp by"
elog "dialing #96*3*"
}
pkg_postrm() {
fdo-mime_desktop_database_update
fdo-mime_mime_database_update
gnome2_icon_cache_update
gnome2_schemas_update
}