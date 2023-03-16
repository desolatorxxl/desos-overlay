EAPI=8

inherit go-module

DESCRIPTION="Go library and CLIs for working with container registries"
HOMEPAGE="https://github.com/google/go-containerregistry"

SRC_URI="https://github.com/google/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SRC_URI+=" https://dist.deso.onl/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT=" test"

src_compile() {
	pushd cmd/crane
	elog "$PWD"
	go build .
	popd
	pushd cmd/gcrane
	elog "$PWD"
	go build .
}

src_install() {
	dobin cmd/crane/crane
	dobin cmd/gcrane/gcrane
}
