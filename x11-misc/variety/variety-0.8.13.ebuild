# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit  distutils-r1


DESCRIPTION="Wallpaper changer for Linux"
HOMEPAGE="https://github.com/varietywalls/variety"
SRC_URI="https://github.com/varietywalls/variety/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE_LINGUAS="bg de es fr ja pl ru uk zh_CN"
IUSE="test $(printf 'linguas_%s ' ${IUSE_LINGUAS})"

DEPEND+="
	>=dev-python/python-distutils-extra-2.18[${PYTHON_USEDEP}]
    test? ( dev-python/pylint[${PYTHON_USEDEP}] )"

RDEPEND+="
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

#S=${WORKDIR}/${PN}

#PATCHES=(
#	"${FILESDIR}"/01_all_variety-0.4.20_436-437.patch
#	"${FILESDIR}"/02_all_variety-0.4.20_tests-fixes.patch
#	"${FILESDIR}"/03_all_variety-0.4.20_desktop_QA_issues.patch
#)

src_install() {
	distutils-r1_src_install

# Install data files (wichtig!)
	insinto /usr/share/variety
	doins -r data/*

# Icons / UI assets
	if [[ -d "${S}/icons" ]]; then
		insinto /usr/share/variety/icons
		doins -r icons/*
	fi

# Desktop + autostart
	if [[ -d "${S}/data" ]]; then
		doins -r data/*
	fi
}


python_prepare_all() {
	# fix incorrect behavior when LINGUAS is set to an empty string
	# https://bugs.launchpad.net/python-distutils-extra/+bug/1133594
	if [[ -z "${LINGUAS}" ]]; then
		LINGUAS='none'
	fi

	distutils-r1_python_prepare_all
}

python_test() {
	# Tests must be run in source directory as this is the only one with expected folder structure.
	cd ${S}/tests || die
    PYTHONPATH="${S}:${PYTHONPATH}" ${PYTHON} -m unittest discover -p '[tT]est*.py' || die "Tests fail with ${EPYTHON}"
}

pkg_postinst() {
	if [ [ -z ${REPLACING_VERSIONS} ] && ! has_version dev-libs/libappindicator:3[introspection] ]; then
		elog "Variety has optional dependency on dev-libs/libappindicator:3[introspection]" \
			" - don’t worry if it is not present, it is for Variety’s indicator icon, " \
			"but Variety will fallback to a classic Gnome status icon if it is not present."
	fi
}
