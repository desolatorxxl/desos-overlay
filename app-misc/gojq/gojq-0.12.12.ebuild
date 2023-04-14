EAPI=8

inherit go-module

DESCRIPTION="Go library and CLIs for working with container registries"
HOMEPAGE="https://github.com/itchyny/gojq"

SRC_URI="$HOMEPAGE/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SRC_URI+=" https://dist.deso.onl/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT=" test"

src_compile() {
	pushd cmd/$PN
	go build .
}

src_install() {
	dobin cmd/$PN/$PN
}
