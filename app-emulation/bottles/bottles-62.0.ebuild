EAPI=8

PYTHON_COMPAT=( python3_11 python3_12 python3_13 )

inherit python-single-r1 desktop xdg

DESCRIPTION="Wine prefix manager focused on gaming and applications"
HOMEPAGE="https://usebottles.com/"
SRC_URI="https://github.com/bottlesdevs/Bottles/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
    ${PYTHON_DEPS}
    dev-python/pygobject
    dev-python/requests
    dev-python/pyyaml
    dev-python/setproctitle
    dev-python/pillow
    dev-python/packaging
    dev-python/psutil
    dev-python/pycairo
    gnome-base/librsvg
    x11-libs/gtk+:3
    app-emulation/wine
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/Bottles-${PV}"

src_prepare() {
    default

    # Flatpak/Zwangssandbox entfernen
    eapply "${FILESDIR}/bottles-no-flatpak.patch"
}

src_install() {
    python_fix_shebang .

    insinto /usr/share/bottles
    doins -r *

    # Startscript
    cat > "${ED}/usr/bin/bottles" <<EOF
#!/bin/sh
exec ${EPYTHON} /usr/share/bottles/main.py "\$@"
EOF

    chmod +x "${ED}/usr/bin/bottles"

    # Desktop Entry
    make_desktop_entry bottles "Bottles" bottles "System;Emulator;Utility;"
}
