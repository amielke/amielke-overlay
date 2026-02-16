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

    insinto "${install_dir}"
    doins -r ${PAYLOAD}/*

    exeinto "${install_dir}"
    doexe ${PAYLOAD}/textmaker
    doexe ${PAYLOAD}/planmaker
    doexe ${PAYLOAD}/presentations

    # Wrapper
    exeinto /usr/bin

    cat > "${T}/textmakernx" <<EOF
#!/bin/sh
exec ${install_dir}/textmaker "\$@"
EOF
    doexe "${T}/textmakernx"

    cat > "${T}/planmakernx" <<EOF
#!/bin/sh
exec ${install_dir}/planmaker "\$@"
EOF
    doexe "${T}/planmakernx"

    cat > "${T}/presentationsnx" <<EOF
#!/bin/sh
exec ${install_dir}/presentations "\$@"
EOF
    doexe "${T}/presentationsnx"

    # Desktop-Dateien – nur einmal, mit MimeType und %U
    make_desktop_entry "textmakernx %U" "TextMaker NX" textmaker "Office;WordProcessor;" \
        "MimeType=application/x-tmd;application/vnd.openxmlformats-officedocument.wordprocessingml.document;application/msword;"

    make_desktop_entry "planmakernx %U" "PlanMaker NX" planmaker "Office;Spreadsheet;" \
        "MimeType=application/x-pmd;application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;application/vnd.ms-excel;"

    make_desktop_entry "presentationsnx %U" "Presentations NX" presentations "Office;Presentation;" \
        "MimeType=application/x-prd;application/vnd.openxmlformats-officedocument.presentationml.presentation;application/vnd.ms-powerpoint;"

    # MIME-Definitionen für SoftMaker-eigene Typen
    insinto /usr/share/mime/packages
    doins ${PAYLOAD}/mime/softmaker-office-nx.xml

    # Icons
    for size in 16 24 32 48 64 128 256 512 1024; do
        newicon -s ${size} ${PAYLOAD}/icons/tml_${size}.png textmaker.png
        newicon -s ${size} ${PAYLOAD}/icons/pml_${size}.png planmaker.png
        newicon -s ${size} ${PAYLOAD}/icons/prl_${size}.png presentations.png
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
