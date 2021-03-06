# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="package to manage versions by scm tags via setuptools"
HOMEPAGE="https://github.com/pypa/setuptools_scm https://pypi.python.org/pypi/setuptools_scm"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="git mercurial test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	distutils_install_for_testing
	py.test -v -v -x -k testing/test_basic_api.py || die "tests failed under ${EPYTHON}"
	py.test -v -v -x -k testing/test_functions.py || die "tests failed under ${EPYTHON}"
	py.test -v -v -x -k testing/test_main.py || die "tests failed under ${EPYTHON}"
	py.test -v -v -x -k testing/test_regressions.py || die "tests failed under ${EPYTHON}"
	if use git; then
		py.test -v -v -x -k testing/test_git.py || die "tests failed under ${EPYTHON}"
	fi
	if use mercurial; then
		py.test -v -v -x -k testing/test_mercurial.py || die "tests failed under ${EPYTHON}"
	fi
}
