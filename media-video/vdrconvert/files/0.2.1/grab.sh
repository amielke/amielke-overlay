#!/bin/sh
# 
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdrconvert/files/0.2.1/grab.sh,v 1.1 2006/03/02 22:41:36 hd_brummy Exp $

. /etc/conf.d/vdrconvert

getvdrversnum()
{
    vdrversnum=$(awk '/VDRVERSNUM/ { gsub("\"","",$3); print $3 }' /usr/include/vdr/config.h)
}

getvdrversnum

[[ "$DVDNORM" = "pal" ]] && RES="720 576" || RES="704 480"

if [[ ${vdrversnum} > "10337" ]] ; then

	(
		$SVDRPSEND GRAB $1 100 $RES
		cp -v /tmp/$1 "$2"
		logger -t ${0##*/} -f /tmp/vdrgrab
	) >/tmp/vdrgrab 2>&1 &

else

	printf "GRAB '%s/%s' %s %d %d %d" "${2}" "${1}" "pnm" 100 $RES | xargs "$SVDRPSEND" >/tmp/vdrgrab 2>&1 &
	logger "`cat /tmp/vdrgrab`"

fi

