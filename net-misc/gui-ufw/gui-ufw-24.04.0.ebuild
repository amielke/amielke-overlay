# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
PYTHON_COMPAT=( python3_{6,7,8,9,11,12,13} )
#DISTUTILS_IN_SOURCE_BUILD=1

#DISTUTILS_SINGLE_IMPL=1
#DISTUTILS_USE_PEP517=setuptools
#PYTHON_COMPAT=( python3_{9..13} )


DESCRIPTION="GUI frontend for managing ufw."
HOMEPAGE="https://gufw.org/ https://costales.github.io/projects/gufw/"
SRC_URI="https://github.com/costales/gufw/releases/download/24.04/gui-ufw-24.04.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/python-distutils-extra"
RDEPEND="net-firewall/ufw
	x11-libs/gtk+:3[introspection]
	net-libs/webkit-gtk[introspection]
	dev-python/netifaces
	sys-auth/polkit
	x11-themes/gnome-icon-theme-symbolic
	dev-python/pygobject:3
"
S=${WORKDIR}/${PN}-${PV}


pkg_postinst() {
	local PYTHONVERSION="$(python -c 'import sys; print("{}.{}".format(sys.version_info.major, sys.version_info.minor))')"
	sed -E "s|share/gufw|lib/python${PYTHONVERSION}/site-packages|g" -i /usr/bin/gufw-pkexec
}
