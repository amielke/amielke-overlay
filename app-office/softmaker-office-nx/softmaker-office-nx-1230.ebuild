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

    # Wrapper scripts
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

    #
    # Desktop entries with full MIME lists (matching official installer)
    #

    # TextMaker
    make_desktop_entry "textmakernx %U" "TextMaker NX" textmaker "Office;WordProcessor;" \
"MimeType=application/x-tmdx;application/x-tmvx;application/x-tmd;application/x-tmv;application/msword;application/vnd.ms-word;application/x-doc;text/rtf;application/rtf;application/vnd.oasis.opendocument.text;application/vnd.oasis.opendocument.text-template;application/vnd.stardivision.writer;application/vnd.sun.xml.writer;application/vnd.sun.xml.writer.template;application/vnd.openxmlformats-officedocument.wordprocessingml.document;application/vnd.ms-word.document.macroenabled.12;application/vnd.openxmlformats-officedocument.wordprocessingml.template;application/vnd.ms-word.template.macroenabled.12;application/x-pocket-word;application/x-dbf;application/msword-template;"

    # PlanMaker
    make_desktop_entry "planmakernx %U" "PlanMaker NX" planmaker "Office;Spreadsheet;" \
"MimeType=application/x-pmd;application/x-pmdx;application/x-pmv;application/excel;application/x-excel;application/x-ms-excel;application/x-msexcel;application/x-sylk;application/x-xls;application/xls;application/vnd.ms-excel;application/vnd.stardivision.calc;application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;application/vnd.openxmlformats-officedocument.spreadsheetml.template;application/vnd.ms-excel.sheet.macroenabled.12;application/vnd.ms-excel.template.macroEnabled.12;application/x-dif;text/spreadsheet;text/csv;application/x-prn;application/vnd.ms-excel.sheet.binary.macroenabled.12;application/vnd.oasis.opendocument.spreadsheet;application/vnd.oasis.opendocument.spreadsheet-template;"

    # Presentations
    make_desktop_entry "presentationsnx %U" "Presentations NX" presentations "Office;Presentation;" \
"MimeType=application/x-prdx;application/x-prvx;application/x-prsx;application/x-prd;application/x-prv;application/x-prs;application/ppt;application/mspowerpoint;application/vnd.ms-powerpoint;application/vnd.openxmlformats-officedocument.presentationml.presentation;application/vnd.ms-powerpoint.presentation.macroenabled.12;application/vnd.openxmlformats-officedocument.presentationml.template;application/vnd.ms-powerpoint.template.macroEnabled.12;application/vnd.ms-powerpoint.slideshow.macroenabled.12;application/vnd.openxmlformats-officedocument.presentationml.slideshow;"

    # SoftMaker MIME XML
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

    elog "SoftMaker Office NX has been installed."
    elog "To set SoftMaker applications as your default handlers, you may run:"
    elog "  xdg-mime default softmaker-office-nx-textmakernx.desktop application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    elog "  xdg-mime default softmaker-office-nx-planmakernx.desktop application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    elog "  xdg-mime default softmaker-office-nx-presentationsnx.desktop application/vnd.openxmlformats-officedocument.presentationml.presentation"
    elog "You may also set defaults for ODT/ODS/ODP and other formats if desired."
}

pkg_postrm() {
    xdg_icon_cache_update
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
}
