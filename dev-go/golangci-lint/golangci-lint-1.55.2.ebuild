EAPI=8

inherit go-module

DESCRIPTION="golangci-lint is a fast Go linters runner."
HOMEPAGE="https://github.com/golangci/golangci-lint"

SRC_URI="https://github.com/golangci/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SRC_URI+=" https://dist.deso.onl/${P}-vendor.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RESTRICT=" test"

src_compile() {
	cd cmd/golangci-lint
	go build || die
}

src_install() {
	dobin cmd/golangci-lint/golangci-lint
	dodoc README.md
}
