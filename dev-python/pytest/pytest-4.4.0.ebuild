# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} pypy{,3} )

inherit distutils-r1

DESCRIPTION="Simple powerful testing with Python"
HOMEPAGE="http://pytest.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="test"

# When bumping, please check setup.py for the proper py version
PY_VER="1.5.0"

# pathlib2 has been added to stdlib before py3.6, but pytest needs __fspath__
# support, which only came in py3.6.
RDEPEND="
	>=dev-python/atomicwrites-1.0[${PYTHON_USEDEP}]
	>=dev-python/attrs-17.4.0[${PYTHON_USEDEP}]
	>=dev-python/more-itertools-4.0.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/pathlib2[${PYTHON_USEDEP}]' python2_7 python3_5 )
	>=dev-python/pluggy-0.9[${PYTHON_USEDEP}]
	>=dev-python/py-${PY_VER}[${PYTHON_USEDEP}]
	>=dev-python/setuptools-40[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	virtual/python-funcsigs[${PYTHON_USEDEP}]"

# flake & pytest-capturelog cause a number of tests to fail
DEPEND="${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? (
		>=dev-python/hypothesis-3.56[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/mock[${PYTHON_USEDEP}]' -2)
		dev-python/requests[${PYTHON_USEDEP}]
		!!dev-python/flaky
		!!<dev-python/pytest-xdist-1.22
	)"

python_prepare_all() {
	grep -qF "py>=${PY_VER}" setup.py || die "Incorrect dev-python/py dependency"

	# Something in the ebuild environment causes this to hang/error.
	# https://bugs.gentoo.org/598442
	rm testing/test_pdb.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	# In v4.1.1, pytest started being picky about its own verbosity options.
	# running pytest on itself with -vv made 3 tests fail. This is why we don't
	# have it below.
	"${EPYTHON}" "${BUILD_DIR}"/lib/pytest.py --lsof -rfsxX \
		|| die "tests failed with ${EPYTHON}"
}
