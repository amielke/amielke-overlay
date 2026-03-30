EAPI=8

PYTHON_COMPAT=( python3_11 python3_12 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Wallpaper changer for Linux"
HOMEPAGE="https://github.com/varietywalls/variety"
SRC_URI="https://github.com/varietywalls/variety/archive/refs/tags/0.8.12.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
    dev-python/pygobject[${PYTHON_USEDEP}]
    dev-python/requests[${PYTHON_USEDEP}]
    dev-python/pillow[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

src_prepare() {
    default
}
