# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="DNS toolkit for Python"
HOMEPAGE="http://www.dnspython.org/ https://pypi.org/project/dnspython/"
SRC_URI="https://github.com/rthalley/dnspython/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="*"
IUSE="examples test"

RDEPEND="dev-python/pycryptodome[${PYTHON_USEDEP}]
	>=dev-python/ecdsa-0.13[${PYTHON_USEDEP}]
	>=dev-python/idna-2.1[${PYTHON_USEDEP}]
	!dev-python/dnspython:py2
	!dev-python/dnspython:py3"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

# For testsuite
DISTUTILS_IN_SOURCE_BUILD=1

python_test() {
	cd tests || die
	"${PYTHON}" utest.py || die "tests failed under ${EPYTHON}"
	einfo "Testsuite passed under ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
