# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

EAPI=2

inherit git-2 eutils webapp depend.php

DESCRIPTION="Web-based configuration tool written to configure Nagios. Update and replace your older version of Lilac or Lilac-Reloaded! This is the Master-Version from GIT."
HOMEPAGE="https://sourceforge.net/projects/lilac--reloaded/"

EGIT_REPO_URI="git://git.code.sf.net/p/lilac--reloaded/code"
EGIT_PROJECT="lilac-reloaded"
#EGIT_MASTER="master"
#EGIT_BRANCH="dev"

SLOT="2.0"
WEBAPP_MANUAL_SLOT="yes"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE="nmap"

RDEPEND=">=virtual/mysql-5.1
	>=net-analyzer/nagios-3.2
	>=dev-php/PEAR-PEAR-1.9.2
	dev-lang/php[curl,json,mysql,pcntl,pdo,posix,simplexml]
	nmap? ( >=net-analyzer/nmap-5.51 )"

need_php_httpd

src_install() {
	webapp_src_preinst

	dodoc INSTALL UPGRADING
	rm -f INSTALL UPGRADING

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR}"/includes/lilac-conf.php.dist
	webapp_serverowned "${MY_HTDOCSDIR}"/includes/lilac-conf.php.dist
	webapp_src_install
}

pkg_postinst () {
		webapp_pkg_postinst
                echo
		ewarn "---------------------------------------------------------------------------"
                ewarn "Is this an upgrade, you will come to upgradepage automaticly"
		ewarn "on the first call of Lilac-Reloaded http://localhost/lilac-reloaded"
                ewarn "If you have problems to upgrade from Lilac previous versions <=2.0"
		ewarn " look at Sourcesforge: http://sourceforge.net/p/lilac--reloaded/discussion/"
		ewarn "---------------------------------------------------------------------------"
                echo
}
