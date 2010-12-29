# $Header: /var/cvsroot/gentoo-x86/media-video/vdrconvert/files/0.2.1/rc-vdrconvert.sh,v 1.2 2006/03/07 19:24:05 hd_brummy Exp $
#
# rc-addon-script for vdrconvert
#

source /etc/conf.d/vdr

load_vdrconvert_conf() {

[[ -e /etc/vdr/vdrconvert/vdrconvert.burn ]] && source /etc/vdr/vdrconvert/vdrconvert.burn
[[ -e /etc/vdr/vdrconvert/vdrconvert.divx ]] && source /etc/vdr/vdrconvert/vdrconvert.divx
[[ -e /etc/vdr/vdrconvert/vdrconvert.dvd ]] && source /etc/vdr/vdrconvert/vdrconvert.dvd
[[ -e /etc/vdr/vdrconvert/vdrconvert.global ]] && source /etc/vdr/vdrconvert/vdrconvert.global
[[ -e /etc/vdr/vdrconvert/vdrconvert.mpeg ]] && source /etc/vdr/vdrconvert/vdrconvert.mpeg
[[ -e /etc/vdr/vdrconvert/vdrconvert.mp3 ]] && source /etc/vdr/vdrconvert/vdrconvert.mp3
[[ -e /etc/vdr/vdrconvert/vdrconvert.vcd ]] && source /etc/vdr/vdrconvert/vdrconvert.vcd
}

: ${VIDEO:=/var/vdr/video}

[[ -z ${VDRROOT} ]] && VDRROOT="${VIDEO}"

[[ -z ${VDRCONVERT_VIDEODIR} ]] && VDRCONVERT_VIDEODIR="${VIDEO}"

[[ -z ${VDRCONVERTDIR} ]] && VDRCONVERTDIR="${VDRCONVERT_VIDEODIR}/.vdrconvert"

# Hardcoded Dir's
: ${VDRCONVERTBINDIR:=/usr/bin}
: ${VCOLOGDIR:=/var/log/vdrconvert}
: ${VCORUNDIR:=/var/run/vdrconvert}
: ${VCOQUEUEDIR:=/var/spool/vdrconvert}
: ${DVD_ANIMATELOGO_FILE:=/usr/share/vdrconvert/images/logos/logosml.256.pnm}
: ${DVDMENUSCHEMA:=duester}
[[ -z ${DVDBUTTONDIR} ]] && DVDBUTTONDIR="/usr/share/vdrconvert/images/buttons/${DVDMENUSCHEMA}"

#load_vdrconvert_conf

export VDRCONVERTDIR VDRCONVERTBINDIR VDRCONVERT_CONF_DIR VCOLOGDIR VCORUNDIR VCOQUEUEDIR
