# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 xdg

MY_PV="0.9.0-b1"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Wallpaper changer"
HOMEPAGE="https://github.com/varietywalls/variety"
SRC_URI="https://github.com/varietywalls/variety/archive/refs/tags/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

S="${WORKDIR}/${MY_P}"

DEPEND="
	>=dev-python/python-distutils-extra-2.18[${PYTHON_USEDEP}]
	test? (
		dev-python/pylint[${PYTHON_USEDEP}]
	)
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
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/pylint[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	# Remove upstream documentation to avoid incorrect installation paths
	rm -f README.md CONTRIBUTING.md AUTHORS || die
	rm -f data/ui/changes.txt || die

	# Variety requires this file; distutils-r1 does not generate it
	cat > variety_lib/variety_build_settings.py <<-EOF || die
__variety_data_directory__ = '/usr/share/variety'
EOF

	# Replace package auto-discovery with an explicit package list to silence
	# setuptools package-discovery QA warnings while still installing jumble.
	sed -i \
		-e "s/packages=find_packages(exclude=\['tests'\]),/packages=['jumble','variety','variety_lib','variety.data','variety.data.config','variety.data.icons','variety.data.icons.scalable','variety.data.icons.scalable.apps','variety.data.media','variety.data.scripts','variety.data.ui'],/" \
		setup.py || die

	# Silence deprecated PEP621 license table warning
	sed -i \
		-e 's/license = { text = "GPL-3.0-only" }/license = "GPL-3.0-only"/' \
		pyproject.toml || die

	distutils-r1_python_prepare_all
}

python_test() {
	cd tests || die
	PYTHONPATH="${S}:${PYTHONPATH}" \
		"${EPYTHON}" -m unittest discover -p '[tT]est*.py' \
		|| die "Tests failed with ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install

	# Install Variety data directory
	insinto /usr/share/variety
	doins -r data/config data/ui data/media data/scripts || die

	# Install desktop templates
	doins \
		data/variety-autostart.desktop.template \
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
