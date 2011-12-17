# Copyright 1999-2010 Tiziano Müller
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils eutils python versionator

DESCRIPTION="Tool for easily browsing and finding files on your computer."
HOMEPAGE="https://launchpad.net/gnome-activity-journal"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=gnome-extra/zeitgeist-0.7.1
	dev-python/pygtk
	dev-python/pygobject
	dev-python/gconf-python
	dev-python/pycairo
	dev-python/libgnome-python
	dev-python/pyxdg
	sys-apps/dbus"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-python/python-distutils-extra"


pkg_postinst() {
	python_mod_optimize /usr/share/gnome-activity-journal
}

pkg_postrm() {
	python_mod_cleanup /usr/share/gnome-activity-journal
}

