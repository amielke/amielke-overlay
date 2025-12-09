# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="threads(+)"

inherit gnome.org gnome2-utils meson virtualx xdg python-single-r1

DESCRIPTION="Gnome Video Player"
HOMEPAGE="https://apps.gnome.org/Showtime/ https://gitlab.gnome.org/GNOME/showtime/"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+python test"
# see bug #359379
REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	>=gui-libs/gtk-4.18.0:4[introspection]
	>=gui-libs/libadwaita-1.8_beta
	python? (
		${PYTHON_DEPS}
	)
"
RDEPEND="${COMMON_DEPEND}
"
BDEPEND="
	virtual/pkgconfig
	dev-util/blueprint-compiler
"

src_prepare() {
	default
	xdg_environment_reset
}

src_configure() {
	local emesonargs=(
		-Dprofile=release
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_fix_shebang "${D}"/usr/bin/showtime
	python_optimize
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}

src_test() {
	virtx meson_src_test
}
