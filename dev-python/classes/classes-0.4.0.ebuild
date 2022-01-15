EAPI=8
DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Sends files to the Trash (or Recycle Bin)"
HOMEPAGE="https://github.com/dry-python/${PN}"
SRC_URI="https://github.com/dry-python/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

BDEPEND="dev-python/pyproject2setuppy"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ~arm ~arm64 hppa ~ia64 ppc ~ppc64 ~riscv ~s390 ~sparc x86"

distutils_enable_tests pytest
