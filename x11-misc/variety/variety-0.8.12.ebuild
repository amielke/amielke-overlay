EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Wallpaper changer for Linux"
HOMEPAGE="https://github.com/varietywalls/variety"
SRC_URI="https://github.com/varietywalls/variety/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Build + Runtime Dependencies
DEPEND="
    dev-python/setuptools[${PYTHON_USEDEP}]
    dev-python/python-distutils-extra[${PYTHON_USEDEP}]
    dev-python/pygobject[${PYTHON_USEDEP}]
    dev-python/requests[${PYTHON_USEDEP}]
    dev-python/pillow[${PYTHON_USEDEP}]
"

RDEPEND="
    ${DEPEND}
    x11-libs/gtk+:3
    x11-misc/xdg-utils
    media-gfx/imagemagick
    x11-apps/feh
    x11-libs/libnotify
"

BDEPEND="
    ${DEPEND}
"

src_prepare() {
    default
}

src_install() {
    distutils-r1_src_install
}
