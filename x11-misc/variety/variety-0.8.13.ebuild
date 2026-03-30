# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 xdg

DESCRIPTION="Wallpaper changer for Linux"
HOMEPAGE="https://github.com/varietywalls/variety"
SRC_URI="https://github.com/varietywalls/variety/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"

DEPEND="
	>=dev-python/python-distutils-extra-2.18[${PYTHON_USEDEP}]
	test? ( dev-python/pylint[${PYTHON_USEDEP}] )
"

RDEPEND="
	x11-libs/libnotify[introspection]
	dev-python/configobj[${PYTHON_USEDEP}]
	media-gfx/exiv2[xmp]
	dev-python/pycurl[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	x11-libs/pango[introspection]
	dev-python/pygobject:3[${PYTHON_USEDEP},cairo]
	dev-python/pillow[${PYTHON_USEDEP}]
	x11-libs/gdk-pixbuf:2[introspection]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	net-libs/webkit-gtk[introspection]
	media-gfx/imagemagick
	dev-python/httplib2[${PYTHON_USEDEP}]
"

python_prepare_all() {
	# Entferne Upstream-Dokumente, die sonst falsch unter /usr/share/doc landen
	rm -f README.md CONTRIBUTING.md AUTHORS || die
	rm -f data/ui/changes.txt || die

	# Variety benötigt diese Datei, distutils-r1 erzeugt sie nicht
	echo "__variety_data_directory__ = '/usr/share/variety'" \
        > variety_lib/variety_build_settings.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	cd tests || die
	PYTHONPATH="${S}:${PYTHONPATH}" \
		"${PYTHON}" -m unittest discover -p '[tT]est*.py' \
		|| die "Tests failed with ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install

	#Installiere die Variety-Datenstruktur
	insinto /usr/share/variety
	doins -r data/config data/ui data/media data/scripts || die

	# Desktop-Templates
	doins data/variety-autostart.desktop.template \
		data/variety-profile.desktop.template || die
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] && ! has_version dev-libs/libappindicator:3[introspection]; then
		elog "Variety has an optional dependency on dev-libs/libappindicator:3[introspection]."
		elog "Without it, a classic tray icon will be used."
	fi

	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

