EAPI=8

inherit go-module

DESCRIPTION="Popeye - A Kubernetes Cluster Sanitizer"
HOMEPAGE="https://github.com/derailed/popeye"

SRC_URI="https://github.com/derailed/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SRC_URI+=" https://dist.deso.onl/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT=" test"

src_compile() {
	emake GOFLAGS="${GOFLAGS}" build
}

src_install() {
	dobin execs/${PN}
}
