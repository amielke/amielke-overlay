# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/googleearth/googleearth-6.2.1.6014.ebuild,v 1.1 2012/03/01 23:07:28 caster Exp $

EAPI="4"

inherit eutils unpacker fdo-mime versionator toolchain-funcs

DESCRIPTION="A 3D interface to the planet"
HOMEPAGE="http://earth.google.com/"
# no upstream versioning, version determined from help/about
# incorrect digest means upstream bumped and thus needs version bump
SRC_URI="x86? ( http://dl.google.com/dl/earth/client/current/google-earth-stable_current_i386.deb
			-> GoogleEarthLnux-${PV}_i386.deb )
	amd64? ( http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
			-> GoogleEarthLinux-${PV}_amd64.deb ) "
LICENSE="googleearth GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"
IUSE="mdns-bundled +qt-bundled"

GCC_NEEDED="4.2"

RDEPEND="|| ( >=sys-devel/gcc-${GCC_NEEDED}[cxx] >=sys-devel/gcc-${GCC_NEEDED}[-nocxx] )
	x86? (
		media-libs/fontconfig
		media-libs/freetype
		virtual/opengl
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXau
		x11-libs/libXdmcp
		sys-libs/zlib
		dev-libs/glib:2
		!qt-bundled? (
			>=x11-libs/qt-core-4.5.3
			>=x11-libs/qt-gui-4.5.3
			>=x11-libs/qt-webkit-4.5.3
		)
		net-misc/curl
		sci-libs/gdal
		!mdns-bundled? ( sys-auth/nss-mdns )
	)
	amd64? (
		>=app-emulation/emul-linux-x86-xlibs-20081109
		>=app-emulation/emul-linux-x86-baselibs-20081109
		app-emulation/emul-linux-x86-opengl
		!qt-bundled? (
			>=app-emulation/emul-linux-x86-qtlibs-20091231-r1
		)
	)
	virtual/ttf-fonts"

DEPEND="dev-util/patchelf"

S="${WORKDIR}/opt/google/earth/free"

pkg_nofetch() {
	einfo "Wrong checksum or file size means that Google silently replaced the distfile with a newer version."
	einfo "Note that Gentoo cannot mirror the distfiles due to license reasons, so we have to follow the bump."
	einfo "Please file a version bump bug on http://bugs.gentoo.org (search existing bugs for googleearth first!)."
	einfo "By redigesting the file yourself, you will install a different version than the ebuild says, untested!"
}

QA_TEXTRELS="opt/googleearth/plugins/imageformats/libqjpeg.so
opt/googleearth/libQtGui.so.4
opt/googleearth/libwebbrowser.so
opt/googleearth/libviewsync.so
opt/googleearth/libspatial.so
opt/googleearth/libsgutil.so
opt/googleearth/libsearch.so
opt/googleearth/libsearchmodule.so
opt/googleearth/librender.so
opt/googleearth/libnavigate.so
opt/googleearth/libmoduleframework.so
opt/googleearth/libmeasure.so
opt/googleearth/liblayer.so
opt/googleearth/libinput_plugin.so
opt/googleearth/libIGGfx.so
opt/googleearth/libgps.so
opt/googleearth/libgooglesearch.so
opt/googleearth/libgoogleearth_free.so
opt/googleearth/libgoogleapi.so
opt/googleearth/libgeobaseutils.so
opt/googleearth/libgdata.so
opt/googleearth/libflightsim.so
opt/googleearth/libevll.so
opt/googleearth/libcommon_webbrowser.so
opt/googleearth/libcommon.so
opt/googleearth/libcommon_platform.so
opt/googleearth/libcollada.so
opt/googleearth/libbasicingest.so
opt/googleearth/libbase.so
opt/googleearth/libauth.so"

pkg_setup() {
	GCC_VER="$(gcc-version)"
	if ! version_is_at_least ${GCC_NEEDED} ${GCC_VER}; then
		ewarn "${PN} needs libraries from gcc-${GCC_NEEDED} or higher to run"
		ewarn "Your active gcc version is only ${GCC_VER}"
		ewarn "Please consult the GCC upgrade guide to set a higher version:"
		ewarn "http://www.gentoo.org/doc/en/gcc-upgrading.xml"
	fi
}

src_unpack() {
	# default src_unpack fails with deb2targz installed, also this unpacks the data.tar.lzma as well
	unpack_deb ${A}

	cd opt/google/earth/free || die

	if ! use qt-bundled; then
		rm -v libQt{Core,Gui,Network,WebKit}.so.4 qt.conf || die
		rm -frv plugins/imageformats || die
	fi
	rm -v libcurl.so.4 || die
	if ! use mdns-bundled; then
		rm -v libnss_mdns4_minimal.so.2 || die
	fi

	if use x86; then
		# no 32 bit libs for gdal
		rm -v libgdal.so.1 || die
	fi
}

src_prepare() {
	# bug #262780 is hopefully now solved upstream
#	epatch "${FILESDIR}/decimal-separator.patch"

	# we have no ld-lsb.so.3 symlink
	# thanks to Nathan Phillip Brink <ohnobinki@ohnopublishing.net> for suggesting patchelf
	patchelf --set-interpreter /lib/ld-linux.so.2 ${PN}-bin || die "patchelf failed"
}

src_install() {
	make_wrapper ${PN} ./${PN} /opt/${PN} . || die "make_wrapper failed"

	# install binaries and remove them
	binaries="${PN} ${PN}-bin *.so *.so.*"
	exeinto /opt/${PN}
	doexe ${binaries} || die
	rm ${binaries}

	insinto /usr/share/mime/packages
	doins "${FILESDIR}/${PN}-mimetypes.xml" || die
	sed "s#/opt/google/earth/free/google-earth/#/opt/${PN}/${PN}#" -i google-earth.desktop || die
	domenu google-earth.desktop
	for size in 16 22 24 32 48 64 128 256 ; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		newins product_logo_${size}.png google-earth.png
	done
	rm -rf product_logo_* xdg-mime xdg-settings google-earth google-earth.desktop || die

	# just copy everything that's left
	cp -pPR * "${D}"/opt/${PN} || die

	# some files are executable and shouldn't
	fperms -R a-x,a+X /opt/googleearth/resources
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	elog "The qt-bundled flag is now enabled by default due to crashes on startup with system Qt."
	elog "Testing and reporting outcome with/without the flag is welcome (bug #319813)."
	elog "If it crashes in both cases, disabling tips is reported to help (bug #354281):"
	elog ""
	elog "When you get a crash starting Google Earth, try adding a file ~./config/Google/GoogleEarthPlus.conf"
	elog "the following options:"
	elog "lastTip = 4"
	elog "enableTips = false"
	elog ""
	elog "In addition, the use of free video drivers may be problems associated with using the Mesa"
	elog "library. In this case, Google Earth 6x likely only works with the Gallium3D variant."
	elog "To select the 32bit graphic library use the command:"
	elog "	eselect mesa list"
	elog "For example, for Radeon R300 (x86):"
	elog "	eselect mesa set r300 2"
	elog "For Intel Q33 (amd64):"
	elog "	eselect mesa set 32bit i965 2"
	elog "You may need to restart X afterwards"
}
