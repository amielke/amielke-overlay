# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit gnome2-utils python-single-r1 meson xdg optfeature

DESCRIPTION="Run Windows software and games on Linux"
HOMEPAGE="https://usebottles.com/"

if [[ "${PV}" == "9999" ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/bottlesdevs/Bottles/"
else
    SRC_URI="https://github.com/bottlesdevs/Bottles/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
    S="${WORKDIR}/Bottles-${PV}"
    KEYWORDS="amd64"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

DEPEND="
    gui-libs/gtk:4[introspection]
    gui-libs/libadwaita[introspection]
"

RDEPEND="
    ${PYTHON_DEPS}
    ${DEPEND}
    app-arch/cabextract
    app-arch/p7zip
    gui-libs/gtksourceview[introspection]
    media-gfx/imagemagick
    >=sys-libs/glibc-2.32
    x11-apps/xdpyinfo
    app-forensics/yara
    $(python_gen_cond_dep '
        dev-python/yara-python[${PYTHON_USEDEP}]
        app-arch/patool[${PYTHON_USEDEP}]
        dev-python/certifi[${PYTHON_USEDEP}]
        dev-python/chardet[${PYTHON_USEDEP}]
        dev-python/charset-normalizer[${PYTHON_USEDEP}]
        dev-python/FVS[${PYTHON_USEDEP}]
        dev-python/idna[${PYTHON_USEDEP}]
        dev-python/icoextract[${PYTHON_USEDEP}]
        dev-python/markdown[${PYTHON_USEDEP}]
        dev-python/orjson[${PYTHON_USEDEP}]
        dev-python/pathvalidate[${PYTHON_USEDEP}]
        dev-python/pefile[${PYTHON_USEDEP}]
        dev-python/pycairo[${PYTHON_USEDEP}]
        dev-python/pycurl[${PYTHON_USEDEP}]
        dev-python/pygobject[${PYTHON_USEDEP}]
        dev-python/pyyaml[${PYTHON_USEDEP}]
        dev-python/requests[${PYTHON_USEDEP}]
        dev-python/urllib3[${PYTHON_USEDEP}]
        dev-python/vkbasalt-cli[${PYTHON_USEDEP}]
        dev-python/wheel[${PYTHON_USEDEP}]
    ')
    || (
        app-emulation/wine-vanilla[X]
        app-emulation/wine-staging[X]
        app-emulation/wine-proton[X(+)]
    )
"

BDEPEND="
    ${PYTHON_DEPS}
    dev-util/blueprint-compiler
    dev-libs/glib:2
    sys-devel/gettext
    test? (
        $(python_gen_cond_dep '
            dev-python/pytest[${PYTHON_USEDEP}]
        ')
    )
"

EPYTEST_DESELECT=(
    "bottles/tests/backend/state/test_events.py::test_set_reset"
    "bottles/tests/backend/state/test_events.py::test_simple_event"
    "bottles/tests/backend/state/test_events.py::test_wait_after_done_event"
)

pkg_setup() {
    python-single-r1_pkg_setup
}

src_prepare() {
    default

    # Remove Flatpak hard requirement
    sed -i \
        -e '/flatpak-info/,+2d' \
        bottles/frontend/meson.build \
        || die
}

src_configure() {
    if [[ "${PV}" == "9999" ]]; then
        local emesonargs=(
            -Ddevel=true
        )
    fi
    meson_src_configure
}

src_install() {
    meson_src_install
    python_optimize "${D}/usr/share/bottles/"
    python_fix_shebang "${D}/usr/"
}

src_test() {
    epytest
}

pkg_preinst() {
    xdg_pkg_preinst
    gnome2_schemas_savelist
}

pkg_postinst() {
    xdg_pkg_postinst
    gnome2_schemas_update
    optfeature "gamemode support" games-util/gamemode
    optfeature "gamescope support" gui-wm/gamescope
    optfeature "vmtouch support" dev-utils/vmtouch

    if has_version app-emulation/wine-vanilla[llvm-libunwind] || \
        has_version app-emulation/wine-staging[llvm-libunwind] || \
        has_version app-emulation/wine-proton[llvm-libunwind]; then
        ewarn "With llvm-libunwind all the runners downloaded from bottles are most likely broken"
        ewarn "So when using llvm-libunwind system wide it is recommended to stick to runners compiled by your system"
        ewarn "More information:"
        ewarn "https://gitlab.com/src_prepare/src_prepare-overlay/-/issues/49"
        ewarn "https://gitlab.com/src_prepare/src_prepare-overlay/-/merge_requests/394"
    fi
}
