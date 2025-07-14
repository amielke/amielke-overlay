# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome.org gnome2-utils meson xdg

DESCRIPTION="A simple tool to create bootable USB drives"
HOMEPAGE="https://flathub.org/apps/io.gitlab.adhami3310.Impression"
SRC_URI="https://gitlab.com/adhami3310/Impression/-/archive/v3.4.0/Impression-v3.4.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/glib:2
        dev-util/meson
        sys-devel/gcc"

RDEPEND="${DEPEND}
        app-arch/xz-utils
        sys-apps/util-linux"
S="${WORKDIR}/Impression-v3.4.0"

pkg_postinst() {
	    gnome2_schemas_update
		    xdg_pkg_postinst
		}

	pkg_postrm() {
		    gnome2_schemas_update
			    xdg_pkg_postrm
			}
