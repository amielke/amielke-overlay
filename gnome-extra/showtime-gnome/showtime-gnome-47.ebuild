# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

inherit gnome2-utils meson xdg

DESCRIPTION="Showtime - Media Player"
HOMEPAGE="https://gitlab.gnome.org/GNOME/showtime"
SRC_URI="https://gitlab.gnome.org/GNOME/showtime/-/archive/gnome-47/showtime-gnome-47.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
    eapply_user
}


pkg_postinst() {
    gnome2_schemas_update
    xdg_pkg_postinst
}

pkg_postrm() {
    gnome2_schemas_update
    xdg_pkg_postrm
}

