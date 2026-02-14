EAPI=8

inherit xdg-utils desktop

DESCRIPTION="SoftMaker Office NX binary package"
HOMEPAGE="https://www.softmaker.com"
SRC_URI="https://www.softmaker.net/down/softmaker-office-nx-${PV//\./-}-amd64.tgz"

LICENSE="SoftMakerOffice"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip mirror"

RDEPEND="
    net-misc/curl
    sys-libs/glibc
    virtual/opengl
    dev-libs/glib
    media-libs/gstreamer
    media-libs/gst-plugins-base
    x11-libs/libX11
    x11-libs/libXext
    x11-libs/libXmu
    x11-libs/libXrandr
    x11-libs/libXrender
"

S="${WORKDIR}"
PAYLOAD="${WORKDIR}/officenx"

QA_PREBUILT="/opt/softmaker-office-nx/*"

src_unpack() {
    unpack ${A}

    mkdir "${PAYLOAD}" || die
    cd "${PAYLOAD}" || die

    xz -dc "${WORKDIR}/officenx.tar.lzma" | tar xf - || die
}

src_install() {
    local install_dir="/opt/softmaker-office-nx"

    # Payload nach /opt
    insinto ${install_dir}
    doins -r ${PAYLOAD}/*

    # Hauptbinaries ausführbar setzen
    exeinto ${install_dir}
    doexe ${PAYLOAD}/textmaker
    doexe ${PAYLOAD}/planmaker
    doexe ${PAYLOAD}/presentations

    # Wrapper-Skripte selbst erstellen
    exeinto /usr/bin

    newexe - textmakernx <<EOF
#!/bin/sh
exec ${install_dir}/textmaker "\$@"
EOF

    newexe - planmakernx <<EOF
#!/bin/sh
exec ${install_dir}/planmaker "\$@"
EOF

    newexe - presentationsnx <<EOF
#!/bin/sh
exec ${install_dir}/presentations "\$@"
EOF

    # Desktopfiles selbst definieren (robust)
    make_desktop_entry textmakernx "TextMaker NX" textmaker Office
    make_desktop_entry planmakernx "PlanMaker NX" planmaker Office
    make_desktop_entry presentationsnx "Presentations NX" presentations Office

    # MIME-Definition
    insinto /usr/share/mime/packages
    doins ${PAYLOAD}/mime/softmaker-office-nx.xml

    # Icons
    for size in 16 24 32 48 64 128 256 512 1024; do
        doicon -s ${size} ${PAYLOAD}/icons/tml_${size}.png
        doicon -s ${size} ${PAYLOAD}/icons/pml_${size}.png
        doicon -s ${size} ${PAYLOAD}/icons/prl_${size}.png
    done
}

pkg_postinst() {
    xdg_icon_cache_update
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
}

pkg_postrm() {
    xdg_icon_cache_update
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
}

