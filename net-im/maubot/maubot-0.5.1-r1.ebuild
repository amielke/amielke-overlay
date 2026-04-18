# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi systemd

DESCRIPTION="Plugin-based Matrix bot system"
HOMEPAGE="https://github.com/maubot/maubot/"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/maubot
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiosqlite[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/asyncpg[${PYTHON_USEDEP}]
	dev-python/bcrypt[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/commonmark[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/mautrix[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/python-olm[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/unpaddedbase64[${PYTHON_USEDEP}]
	dev-python/yarl[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

src_install() {
	distutils-r1_src_install

	keepdir /var/log/maubot
	fowners root:maubot /var/log/maubot
	fperms 0770 /var/log/maubot

	keepdir /var/lib/maubot
	keepdir /var/lib/maubot/plugins
	keepdir /var/lib/maubot/trash
	fowners root:maubot /var/lib/maubot
	fowners root:maubot /var/lib/maubot/plugins
	fowners root:maubot /var/lib/maubot/trash
	fperms 0770 /var/lib/maubot
	fperms 0770 /var/lib/maubot/plugins
	fperms 0770 /var/lib/maubot/trash

	sed -i \
		-e "s#sqlite:${PN}\.db#sqlite:/var/lib/maubot/${PN}.db#" \
		-e "s#\./${PN}\.log#/var/log/maubot/${PN}.log#" \
		-e "s#\./plugins#/var/lib/maubot/plugins#g" \
		-e "s#\./trash#/var/lib/maubot/trash#g" \
		"${ED}/usr/example-config.yaml" || die

	insinto /etc/maubot
	newins "${ED}/usr/example-config.yaml" "${PN}.yaml"
	rm "${ED}/usr/example-config.yaml" || die

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"

	fowners root:maubot /etc/maubot
	fperms 0750 /etc/maubot
	fowners root:maubot /etc/maubot/${PN}.yaml
	fperms 0640 /etc/maubot/${PN}.yaml
}
